import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_myinsta2/model/post_model.dart';
import 'package:flutter_myinsta2/services/data_service.dart';

class MyFeedPage extends StatefulWidget {
  PageController pageController;
  MyFeedPage({this.pageController});
  @override
  _MyFeedPageState createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {
  List<Post> items = new List();
  bool isLoading = false;


  void _apiLoadFeeds(){
    setState(() {
      isLoading = true;
    });
    DataService.loadFeeds().then((value) => {
      _resLoadFeeds(value),
    });
  }

  void _resLoadFeeds(List<Post> posts) {
    setState(() {
      items = posts;
      isLoading = false;
    });
  }

  @override
  void initState(){
    //  TODO: implement initState
    super.initState();
    _apiLoadFeeds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          margin: EdgeInsets.only(left: 140),
          child: Text(
            "Instagram",
            style: TextStyle(color: Colors.black,fontFamily: "Billabong",fontSize: 30),
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.camera_alt,color: Color.fromRGBO(245,96,64,1),),
              onPressed: (){
                widget.pageController.animateToPage(2,
                    duration: Duration(milliseconds: 200), curve: Curves.easeIn);
              }
          )
        ],
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
                            post.fullname,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black
                            ),
                          ),
                          Text(
                            post.date,
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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            imageUrl: post.img_post,
            placeholder: (context,url) => Center(child: CircularProgressIndicator(),),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          ),
          //#Likeshare
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(FontAwesome.heart_o),
                      onPressed: null
                  ),
                  IconButton(
                      icon: Icon(Icons.share),
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
