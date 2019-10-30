import 'package:flutter/material.dart';
import '../main.dart';
import 'Item/Add_item.dart' as add_item;
import 'Item/Delete_Item.dart' as delet_item;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Others/Tutorial.dart' as tutorial;
import '../Front-end/Item/cart.dart'as cart;
import 'Others/Video.dart';
import 'Item/List_item.dart' as homes;
// class myData{
//   String item_id,String item_name;
//   myData
// }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController tab_controller;
  @override
  void initState() { 
     tab_controller=new TabController(vsync: this,length: 3);
    super.initState();
    
  }
   @override
  void dispose() { 
    tab_controller.dispose();
    super.dispose();
  }

  int _bottomNavIndex = 0;
  Widget appBarTitle = new Text('RPOS SYSTEM',style: TextStyle(wordSpacing: 2),);
  Icon actionIcon = new Icon(Icons.search);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar:
          new AppBar(centerTitle: true, title: appBarTitle,
          backgroundColor: Colors.deepPurple,
          bottom: TabBar(
              controller: tab_controller,
              tabs: <Widget>[
                new Tab(
                icon: Icon(Icons.home,color: Colors.blue,),
                text: 'HOME',
                
                ),
                new Tab(
                  icon: Icon(Icons.add_circle,
                  color: Color(0XFF2BD093)),
                  text: 'ADD ITEM',
                  
                  ),
                  new Tab(
                  icon: Icon(Icons.shopping_cart,
                  color: Color(0XFFFC7B4D),),
                  text: 'Cart',
                  ),
                 
              ],
          ),
           actions: <Widget>[
        new IconButton(
          icon: actionIcon,
          onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = new Icon(Icons.close);
                this.appBarTitle = new TextField(
                  style: new TextStyle(
                    color: Colors.white,
                  ),
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search, color: Colors.white),
                      hintText: "Search...",
                      hintStyle: new TextStyle(color: Colors.white)),
                );
              } else {
                this.actionIcon = new Icon(Icons.search);
                this.appBarTitle = new Text("Home Page");
              }
            });
          },
        ),
        new IconButton(
          icon: new Icon(
            FontAwesomeIcons.shoppingCart,
            color: Colors.white,
          ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>cart.Cart()));
          }
        )
      ]),

      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountEmail: new Text("k164037@nu.edu.pk"),
              accountName: new Text("Ubaid Ur Rehman"),
              currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  child: Icon(
                    Icons.account_circle,
                  ),
                ),
                onTap: () => print("This is your current account."),
              ),
              otherAccountsPictures: <Widget>[
                new GestureDetector(
                  child: new CircleAvatar(
                    child: Icon(
                      Icons.account_circle,
                    ),
                  ),
                  onTap: () {
                   
                  },
                ),
              ],
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new NetworkImage(
                          "https://images.unsplash.com/photo-1502060329973-30dd70d9a1c6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"),
                      fit: BoxFit.fill)),
            ),
            new ListTile(
                title: new Text("Account Information"),
                trailing: new Icon(Icons.info),
                onTap: () {
                  Navigator.of(context).pop();
                }),
            new ListTile(
                title: new Text("Tutorial"),
                trailing: new Icon(Icons.videocam),
                onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoApp()));
                }),
            new Divider(),
            new ListTile(
                title: new Text("LogOut"),
                trailing: new Icon(Icons.lock_outline),
                onTap: () {
                  logoutDialog(context);
                }),
          ],
        ),
      ),
      body: new TabBarView(
      controller: tab_controller,
          children: <Widget>[
            new homes.NewHome(),
            new add_item.AddItem(),
            new cart.Cart()

          ],
          ),
      
    );
  }

  Future<void> logoutDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Logout'),
            content: Text('Do You Want To Logout?'),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp())),
              ),
            ],
          );
        });
  }
}

// class MainContent extends StatelessWidget {
//   myData d = new myData("", "", "", "");
//   List<myData> alldata = [];
//   // getitem(alldata);
//   @override
//   Widget build(BuildContext context) {
//     // 
//   }

  