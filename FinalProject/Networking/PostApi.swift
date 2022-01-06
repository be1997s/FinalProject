//
//  PostApi.swift
//  FinalProject
//
//  Created by BE X on 16/05/1443 AH.
//

import UIKit
import Alamofire
import SwiftyJSON
class PostApi : Api{
    
    //get all posts
    static func gatPosts(page : Int , tag : String?,completionhandler : @escaping  ([Post],Int) -> ()){
        var url = PostUrl+"?page=\(page)&limit=5"
        
        if var tagg = tag {
            var tagg = tagg.trimmingCharacters(in: .whitespaces)
            url = "https://dummyapi.io/data/v1/tag/\(tagg)/post"
        }
        
        AF.request(url , headers: header).responseJSON { (res) in
            let jsonData = JSON(res.value)
            let data = jsonData["data"]
            let total = jsonData["total"].intValue
            let decoder = JSONDecoder()
            do{
                 let PostsArray = try decoder.decode([Post].self,from : data.rawData())
                completionhandler(PostsArray,total)
                 
            }   catch let error {    print(error) }
        }
    }

    
    //get post comments
    static func gatComment(id:String,completionhandler : @escaping  ([Comments]) -> ()){
        
        let urll = "https://dummyapi.io/data/v1/post/\(id)/comment"
        AF.request(urll , headers: header).responseJSON { (res) in
        let jsonData = JSON(res.value)
        let data = jsonData["data"]
        let decoder = JSONDecoder()
        do{
                let CommentsArray = try decoder.decode([Comments].self,from : data.rawData())
            completionhandler(CommentsArray)
        }   catch { print("error in rawdata Comments") }
        
    }
}
    //get specific post
    static func gatPost(id:String,completionhandler : @escaping  (Post) -> ()){
        let urll = "https://dummyapi.io/data/v1/post/\(id)"
        AF.request(urll , headers: header).responseJSON { (res) in
        let jsonData = JSON(res.value)
        let decoder = JSONDecoder()
        do{
            let post = try decoder.decode(Post.self,from : jsonData.rawData())
            completionhandler(post)
        }   catch let err {    print(err) }
        
    }
}
    //get posts by user id
    static func gatPostbyUser(id:String,completionhandler : @escaping  ([Post]) -> ()){
        let urll = "https://dummyapi.io/data/v1/user/\(id)/post"
        AF.request(urll , headers: header).responseJSON { (res) in
                let jsonData = JSON(res.value)
                let data = jsonData["data"]
                let total = jsonData["total"].intValue
                let decoder = JSONDecoder()
                do{
                     let PostsArray = try decoder.decode([Post].self,from : data.rawData())
                    completionhandler(PostsArray)
                     
                }   catch let error {    print(error) }
            }
        
    }

    //get user profile
    
    static func gatProfileinfo(id:String,completionhandler : @escaping  (User) -> ()){
        
        let urll = userUrl+id
        AF.request(urll , headers: header).responseJSON { (res) in
            let jsonData = JSON(res.value)
            let decoder = JSONDecoder()
            do{
                let user = try decoder.decode(User.self,from : jsonData.rawData())
                completionhandler(user)
            }   catch {    print("error in rawdata account") }
            
        }

}
    
    //Regesiter New User
    static func NewUser(fristname : String,lastname : String,email : String,completionhandler : @escaping  (User?,String?) -> ()){
        let userData = [
           "firstName": fristname,
           "lastName" : lastname,
           "email" : email,
            "picture" : "https://support.jfrog.com/profilephoto/72969000000Qdj1/M"
        ]
        
        AF.request("https://dummyapi.io/data/v1/user/create" ,method: HTTPMethod.post,parameters: userData,encoder: JSONParameterEncoder.default, headers: header).validate().responseJSON { (res) in
           
            switch res.result{
            case .success :
        let jsonData = JSON(res.value)
        let decoder = JSONDecoder()
        do{
             let userr = try decoder.decode(User.self,from : jsonData.rawData())
            completionhandler(userr,nil)
        }
        catch let error{    print(error) }
        case .failure(let error):
            let jsondata = JSON(res.data)
            let data = jsondata["data"]
            let emailError = data["email"].stringValue
            let firstNameError = data["firstName"].stringValue
            let lastNameError = data["lastName"].stringValue
            let errorMessage = emailError + " " + firstNameError + " " + lastNameError
            completionhandler(nil,errorMessage)
        }
    }
    }
    
    //sign in check
    static func SignIn(firstname : String,lastname : String,completionhandler : @escaping  (User?,String?) -> ()){

        AF.request("https://dummyapi.io/data/v1/user?created=1" , headers: header).responseJSON { (res) in
            let jsonData = JSON(res.value)
            let data = jsonData["data"]
            let decoder = JSONDecoder()
            do{
                 let UserArray = try decoder.decode([User].self,from : data.rawData())
                
                var user : User?
                for i in UserArray {
                    if i.firstName == firstname && i.lastName == lastname {
                        user = i
                        break
                    }
                }
                if user != nil {completionhandler(user!,nil)} else {
                    completionhandler(nil,"Data are incorrect!")
                }
                
                
                 
            }   catch {    print("error in rawdata") }
        }
    }
    
    //edit user data
    static func editUserinfo(id:String,firstname : String,picture:String,phone : String,dateOfBirth : String,gender:String,completionhandler : @escaping  (User?,String?) -> ()){
        let params = [
            "firstName":firstname,
            "phone" : phone,
            "dateOfBirth":dateOfBirth,
            "gender":gender,
            "picture":picture
        ]
        AF.request("https://dummyapi.io/data/v1/user/\(id)" ,method: .put,parameters: params,encoder: JSONParameterEncoder.default, headers: header).validate().responseJSON { (res)  in
            switch res.result{
            case .success :
        let jsonData = JSON(res.value)
        let decoder = JSONDecoder()
        do{
             let userr = try decoder.decode(User.self,from : jsonData.rawData())
            completionhandler(userr,nil)
        }
        catch let error{    print(error) }
        case .failure(let error):
            completionhandler(nil,error.errorDescription)
        }
    }
    }
    
    // add comment to post
    static func addComment(id: String,Postid: String,messege: String,completionhandler : @escaping  () -> ()){
        let CommentData = [
            "message" : messege,
            "owner" : id,
            "post"   : Postid,
        ]
        
        AF.request("https://dummyapi.io/data/v1/comment/create" ,method: HTTPMethod.post,parameters: CommentData,encoder: JSONParameterEncoder.default, headers: header).validate().responseJSON { (res) in
           
            switch res.result{
            case .success :
        let jsonData = JSON(res.value)
            completionhandler()
           
        case .failure(let error):
            print(error)
        }
    }
    }
    
    //add post
    static func addPost(id: String,text: String,image:String?,tags: [String],completionhandler : @escaping  () -> ()){
        
        var PostData = [
            "text" : text,
            "tags" :  tags ,
            "owner"   : id] as [String : Any]
        
        if image != nil  {
         PostData = [
            "text" : text,
            "image" : image!,
            "tags" :  tags ,
            "owner"   : id] as [String : Any]
        }
        
        AF.request("https://dummyapi.io/data/v1/post/create" ,method: HTTPMethod.post,parameters: PostData, headers: header).validate().responseJSON { (res) in
           
            switch res.result{
            case .success :
        let jsonData = JSON(res.value)
            completionhandler()
           
        case .failure(let error):
            print(error)
        }
    }
    }
    
    
  // get all tags
    static func gatTags(completionhandler : @escaping  ([String]) -> ()){

        AF.request("https://dummyapi.io/data/v1/tag" , headers: header).responseJSON { (res) in
            let jsonData = JSON(res.value)
            let data = jsonData["data"]
            let decoder = JSONDecoder()
            do{
                 let TagsArray = try decoder.decode([String].self,from : data.rawData())
                completionhandler(TagsArray)
                 
            }   catch {    print("error in rawdata") }
        }
    }
    
    //delete post
    
    static func deletePost(id: String,completionhandler : @escaping  (String?) -> ()){

        AF.request("https://dummyapi.io/data/v1/post/\(id)" ,method: .delete, headers: header).validate().responseJSON { (res) in
            switch res.result{
            case .success :
        let jsonData = JSON(res.value)
            completionhandler(nil)
           
        case .failure(let error):
            print(error)
            completionhandler(error.errorDescription)
        }
    }
    }
 
 }
