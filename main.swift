//
//  main.swift
//  FirstCourseFinalTask
//
//  Copyright © 2017 E-Legion. All rights reserved.
//
import Foundation
import FirstCourseFinalTaskChecker


struct post: PostProtocol
{
    var like: [(UserProtocol.Identifier, PostProtocol.Identifier)]
    
    var cid: UserProtocol.Identifier
    
    var id: Identifier
    
    var author: GenericIdentifier<UserProtocol>
    
    var description: String
    
    var imageURL: URL
    
    var createdTime: Date
    
    var currentUserLikesThisPost: Bool
    {
        get{
            return like.contains(where: {$0 == (cid,id)})
        }
    }
    
    var likedByCount: Int
    {
        get{
            var count: Int = 0
            for elem in like
            {
                if elem.1 == id
                {
                    count += 1
                }
            }
            return count
        }
    }
    
    
}

struct user: UserProtocol
    {
    
    //var allusers: [UserInitialData]
    
    var followers: [(UserProtocol.Identifier, UserProtocol.Identifier)]
    
    var cid: UserProtocol.Identifier
    
    var id: Identifier
    
    var username: String
    
    var fullName: String
    
    var avatarURL: URL?
    
    var currentUserFollowsThisUser: Bool
    {get
        {
            return followers.contains{$0 == (cid, id)}
        }
    }
    
    var currentUserIsFollowedByThisUser: Bool
    {get
        {
            return followers.contains{$0 == (id, cid)}
        }
    }
    
    var followsCount: Int
    {
        get
        {
            var count = 0
            for i in followers
            {
                if id == i.0
                {
                    count += 1
                }
            }
            return count
        }
    }
    
    var followedByCount: Int
    {
        get
        {
            var count = 0
            for i in followers
            {
                if id == i.1
                {
                    count += 1
                }
            }
            return count
        }
    }
    }

class cuser: UsersStorageProtocol
{
     
 var allusers: [UserInitialData]
 var allfollowers: [(UserProtocol.Identifier, UserProtocol.Identifier)]
 var currentid: UserProtocol.Identifier
    
    required init?(users: [UserInitialData], followers: [(GenericIdentifier<UserProtocol>, GenericIdentifier<UserProtocol>)], currentUserID:  GenericIdentifier<UserProtocol>) {
        self.allusers = users
        self.allfollowers = followers
        if users.contains(where: {$0.id == currentUserID}) != true
        {
            return nil
        }
        self.currentid = currentUserID
        self.count = users.count
    }
    
    var count: Int
            
    func currentUser() -> UserProtocol {
        var username: String = ""
        var fullName: String = ""
        for elem in allusers
        {
            if elem.id == currentid
            {
                username = elem.username
                fullName = elem.fullName
            }
        }
        let newuser = FirstCourseFinalTask.user(followers: allfollowers, cid: currentid, id: currentid, username: username, fullName: fullName)
        return newuser
    }
    
    func user(with userID: GenericIdentifier<UserProtocol>) -> UserProtocol? {
        var newuser = FirstCourseFinalTask.user(followers: allfollowers, cid: currentid, id: currentid, username: "", fullName: "")
        for elem in allusers
        {
            if elem.id == userID
            {
                newuser.id = elem.id
                newuser.username = elem.username
                newuser.fullName = elem.fullName
                newuser.avatarURL = elem.avatarURL
                return newuser
            }
        }
        return nil
    }
    
    func findUsers(by searchString: String) -> [UserProtocol] {
        var result: [UserProtocol] = []
        for elem in allusers
        {
            if elem.fullName.contains(searchString)
            {
                let newuser = FirstCourseFinalTask.user(followers: allfollowers, cid: currentid, id: elem.id, username: elem.username, fullName: elem.fullName)
                result.append(newuser)
            }
            else
            {
                if elem.username.contains(searchString)
                {
                    let newuser = FirstCourseFinalTask.user(followers: allfollowers, cid: currentid, id: elem.id, username: elem.username, fullName: elem.fullName)
                    result.append(newuser)
                }
            }
        }
        return result
    }
    
    func follow(_ userIDToFollow: GenericIdentifier<UserProtocol>) -> Bool {
        var fu : [UserProtocol.Identifier] = []
        for elem in allusers
        {
            fu.append(elem.id)
        }
        if fu.contains(where: {$0 == userIDToFollow})
        {
            if allfollowers.contains(where: {$0 == (currentid,userIDToFollow)})
            {
                
            }
            else
            {
                allfollowers.append((currentid,userIDToFollow))
            }

        }
        else
        {
            return false
        }
        return true
    }
    
    func unfollow(_ userIDToUnfollow: GenericIdentifier<UserProtocol>) -> Bool {
        var fu : [UserProtocol.Identifier] = []
        for elem in allusers
        {
            fu.append(elem.id)
        }
        if fu.contains(where: {$0 == userIDToUnfollow})
        {
            if allfollowers.contains(where: {$0 == (currentid,userIDToUnfollow)})
            {
                for (x,i) in allfollowers.enumerated()
                {
                    if i == (currentid,userIDToUnfollow)
                    {
                        allfollowers.remove(at: x)
                    }
                }
                
            }
            
        }
        else
        {
            return false
        }
        return true
    }
    
    func usersFollowingUser(with userID: GenericIdentifier<UserProtocol>) -> [UserProtocol]? {
        var result: [UserProtocol] = []
        var fu : [UserProtocol.Identifier] = []
        for elem in allusers
        {
            fu.append(elem.id)
        }
        if fu.contains(where: {$0 == userID})
        {
          for elem in allusers
          {
              let newuser = FirstCourseFinalTask.user(followers: allfollowers, cid: userID, id: elem.id, username: elem.username, fullName: elem.fullName)
              if newuser.currentUserIsFollowedByThisUser == true
              {
                  result.append(newuser)
              }
          }
        }
        else
        {
            return nil
        }
        
        return result
    }
    
    func usersFollowedByUser(with userID: GenericIdentifier<UserProtocol>) -> [UserProtocol]? {
        var result: [UserProtocol] = []
        var fu : [UserProtocol.Identifier] = []
        for elem in allusers
        {
            fu.append(elem.id)
        }
        if fu.contains(where: {$0 == userID})
        {
          for elem in allusers
          {
              let newuser = FirstCourseFinalTask.user(followers: allfollowers, cid: userID, id: elem.id, username: elem.username, fullName: elem.fullName)
              if newuser.currentUserFollowsThisUser == true
              {
                  result.append(newuser)
              }
          }
        }
        else
        {
            return nil
        }
        
        return result
    }
    
   
    
        
}
class cpost: PostsStorageProtocol
{
    var allposts: [PostInitialData]
    var alllike: [(UserProtocol.Identifier, PostProtocol.Identifier)]
    var currentid: UserProtocol.Identifier
    required init(posts: [PostInitialData], likes: [(GenericIdentifier<UserProtocol>, GenericIdentifier<PostProtocol>)], currentUserID: GenericIdentifier<UserProtocol>) {
        self.allposts = posts
        self.alllike = likes
        self.currentid = currentUserID
        self.count = posts.count
    }
    
    var count: Int
    
    func post(with postID: GenericIdentifier<PostProtocol>) -> PostProtocol? {
        var id: PostProtocol.Identifier = ""
        var author: UserProtocol.Identifier = ""
        var description: String = ""
        var imageURL =  URL(string: "")
        var createdTime = Date()
        var list: [PostProtocol.Identifier] = []
        for elem in allposts
        {
            list.append(elem.id)
        }
        if list.contains(where: {$0 == postID})
        {
            for elem in allposts
            {
                if elem.id == postID
                {
                    id = elem.id
                    author = elem.author
                    description = elem.description
                    imageURL = elem.imageURL
                    createdTime = elem.createdTime
                }
            }
        }
        else
        {
            return nil
        }
        let newpost = FirstCourseFinalTask.post(like: alllike, cid: currentid, id: id, author: author, description: description, imageURL: imageURL!, createdTime: createdTime)
        return newpost
    }
    
    func findPosts(by authorID: GenericIdentifier<UserProtocol>) -> [PostProtocol] {
        var result: [PostProtocol] = []
        for elem in allposts
        {
            if elem.author == authorID
            {
                let newpost = FirstCourseFinalTask.post(like: alllike, cid: currentid, id: elem.id, author: elem.author, description: elem.description, imageURL: elem.imageURL, createdTime: elem.createdTime)
                result.append(newpost)
            }
        }
        return result
    }
    
    func findPosts(by searchString: String) -> [PostProtocol] {
        var result: [PostProtocol] = []
        for elem in allposts
        {
            if elem.description.contains(searchString)
            {
                let newpost = FirstCourseFinalTask.post(like: alllike, cid: currentid, id: elem.id, author: elem.author, description: elem.description, imageURL: elem.imageURL, createdTime: elem.createdTime)
                result.append(newpost)
            }
        }
        return result
    }
    
    func likePost(with postID: GenericIdentifier<PostProtocol>) -> Bool {
        if allposts.contains(where: {$0.id == postID}) != true{
            return false
        }
        alllike.append((currentid,postID))
        return true
    }
    
    func unlikePost(with postID: GenericIdentifier<PostProtocol>) -> Bool {
        if allposts.contains(where: {$0.id == postID}) != true{
            return false
        }
        alllike.removeAll(where: {$0 == (currentid,postID)})
        return true
    }
    
    func usersLikedPost(with postID: GenericIdentifier<PostProtocol>) -> [GenericIdentifier<UserProtocol>]? {
        if allposts.contains(where: {$0.id == postID}) != true{
            return nil
        }
        var result: [UserProtocol.Identifier] = []
        for elem in alllike {
            if elem.1 == postID
            {
                result.append(elem.0)
            }
        }
        return result
    }
    
    
    
    
    
}

let checker = Checker(usersStorageClass: cuser.self,
                      postsStorageClass: cpost.self)
checker.run()

