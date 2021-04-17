import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_myinsta2/model/post_model.dart';

class MyLikesPage extends StatefulWidget {
  @override
  _MyLikesPageState createState() => _MyLikesPageState();
}

class _MyLikesPageState extends State<MyLikesPage> {
  List<Post> items = new List();
  String post_img1 = "https://firebasestorage.googleapis.com/v0/b/koreanguideway.appspot.com/o/develop%2Fpost.png?alt=media&token=f0b1ba56-4bf4-4df2-9f43-6b8665cdc964";
  String post_img2 = "https://firebasestorage.googleapis.com/v0/b/koreanguideway.appspot.com/o/develop%2Fpost2.png?alt=media&token=ac0c131a-4e9e-40c0-a75a-88e586b28b72";

  @override
  void initState(){
    //  TODO: implement initState
    super.initState();
    items.add(Post(img_post: post_img1,caption: "Discover more great images on our sponsor's site"));
    items.add(Post(img_post: post_img2,caption: "Discover more great images on our sponsor's site"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            "Likes",
            style: TextStyle(color: Colors.black,fontFamily: "Billabong",fontSize: 30),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx,index){
          return _itemsOfPost(items[index]);
        },
      ),
    );
  }
  Widget _itemsOfPost(Post post){
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Divider(),
          //#Userinfo
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image(
                          image: AssetImage("assets/images/ic_person.png"),
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Username",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black
                            ),
                          ),
                          Text(
                            "February 2, 2020",
                            style: TextStyle(
                                fontWeight: FontWeight.normal
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  IconButton(
                      icon: Icon(SimpleLineIcons.options),
                      onPressed: (){}
                  ),
                ],
              )
          ),

          //#Image
          // Image.network(post.postImage,fit: BoxFit.cover,),
          CachedNetworkImage(
            imageUrl: post.img_post,
            placeholder: (context,url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          //#Likeshare
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(FontAwesome.heart,color: Colors.red,),
                      onPressed: null
                  ),
                  IconButton(
                      icon: Icon(FontAwesome.send),
                      onPressed: null
                  ),
                ],
              )
            ],
          ),

          //  #caption
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: RichText(
              softWrap: true,
              overflow: TextOverflow.visible,
              text: TextSpan(
                  children: [
                    TextSpan(
                        text: " ${post.caption}",
                        style: TextStyle(color: Colors.black)
                    )
                  ]
              ),
            ),
          )
        ],
      ),
    );
  }
}
