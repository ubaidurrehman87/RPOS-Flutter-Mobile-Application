import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../Database/Item/item.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:photo/photo.dart';
// import 'package:photo_manager/photo_manager.dart';

class AddItem extends StatefulWidget {
  final Widget child;

  AddItem({Key key, this.child}) : super(key: key);

  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {

  
  
  String selected; 
 
  TextEditingController name_control = new TextEditingController();
  TextEditingController id_control = new TextEditingController();
  TextEditingController category_control = new TextEditingController();
  TextEditingController price_control=new TextEditingController();

  String _id, _name, _category,_price;
  File _image;
  bool name_validate = false;
  bool id_validate = false;
  bool category_validate = false;
  bool price_validate=false;

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color(0XFF2BD093),
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                width: 150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                  border: Border.all(style: BorderStyle.solid)
                ),
                child: _image == null
                     ? IconButton(
                       icon: Icon(Icons.add_a_photo),
                       onPressed: addimage,
                       color: Colors.blueAccent,
                      iconSize: 50,
                      splashColor: Colors.white,
                      
                     )
                   
                    : Image.file(_image,fit: BoxFit.fill,width: 130,),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.info),
                      labelText: 'Item ID*',
                      errorText: id_validate ? 'Enter ID Of Item' : null,
                      fillColor: Colors.greenAccent,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  controller: id_control,
                  keyboardType: TextInputType.number,
                  onChanged: (v) => _id = v,
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.add_box),
                      labelText: 'Item Name*',
                      fillColor: Colors.indigo,
                      errorText: name_validate ? 'Enter name of Item' : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    controller: name_control,
                    keyboardType: TextInputType.text,
                    onChanged: (v) => _name = (v),
                  )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextField(
                      controller: price_control,
                      
                      decoration: InputDecoration(
                        icon: Icon(Icons.attach_money),
                        labelText: 'Price*',
                        errorText: price_validate ? 'Enter Price <100000 ' : null ,
                        fillColor: Colors.indigo,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                      keyboardType: TextInputType.numberWithOptions(),
                      onChanged: (v)=>_price=v,
                    ),
                  ),
            
              //  height: 10,
            Padding(

                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Container(
                    
                  child:DropdownButtonFormField<String>(
                            value: selected,

                            decoration: InputDecoration(
                              icon: Icon(Icons.category),
                              labelText: 'Category',
                              contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              // errorText: category_validate ? 'Select Category':null,
                              // focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                            ),
                            items: ["A", "B", "C"]
                                .map((label) => DropdownMenuItem(
                                      child: Text(label),
                                      value: label,
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() => selected = value);
                              _category=value;
                            },
                          )
                  ),
             ),
                  new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(100, 10, 100,50),
                  child: GestureDetector(
                    onTap: () {
                     setState(() {
                        id_control.text.isEmpty
                            ? id_validate = true
                            : id_validate = false;
                        name_control.text.isEmpty
                            ? name_validate = true
                            : name_validate = false;
                        price_control.text.isEmpty
                            ? price_validate=true
                            :int.parse(price_control.text)<100000
                            ? price_validate=false
                            : price_validate=true;


                      }
                      );
                      if(id_validate==name_validate && price_validate==name_validate && name_validate==false && _image!=null){
                         print(price_control.text);
                         //image upload to Storage
                         final StorageReference filerefrence=FirebaseStorage.instance.ref().child(_id);
                          final StorageUploadTask uploadTask=filerefrence.putFile(_image);
                          
                        additem(_id,_name,_price,_category,context);
                      }
                    },
                    child: new Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        decoration: new BoxDecoration(
                            color: Color(0XFF2BD093),
                            borderRadius: new BorderRadius.circular(25.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: new Icon(
                                Icons.add_circle_outline,
                                color: Colors.white,
                              ),
                            ),
                            new Text(
                              "Add Item",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )),
                  ),
                ))
              ],
            ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: addimage,
      //   backgroundColor: Color(0XFF2BD093),
      //   label: Text('Take'),
      //   icon: Icon(Icons.add_a_photo),
        
      // ),
    );
  }

  addimage() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = img;
    });
  }
//   void _pickImage() async {
//     List<AssetEntity> imgList = await PhotoPicker.pickAsset(
//       context: context,
//       // BuildContext requied

//       /// The following are optional parameters.
//       themeColor: Colors.green,
//       // the title color and bottom color
//       padding: 1.0,
//       // item padding
//       dividerColor: Colors.grey,
//       // divider color
//       disableColor: Colors.grey.shade300,
//       // the check box disable color
//       itemRadio: 0.88,
//       // the content item radio
//       maxSelected: 8,
//       // max picker image count
//       provider: I18nProvider.chinese,
//       // i18n provider ,default is chinese. , you can custom I18nProvider or use ENProvider()
//       rowCount: 5,
//       // item row count
//       textColor: Colors.white,
//       // text color
//       thumbSize: 150,
//       // preview thumb size , default is 64
//       sortDelegate: SortDelegate.common,
//       // default is common ,or you make custom delegate to sort your gallery
//       checkBoxBuilderDelegate: DefaultCheckBoxBuilderDelegate(
//         activeColor: Colors.white,
//         unselectedColor: Colors.white,
//       ), // default is DefaultCheckBoxBuilderDelegate ,or you make custom delegate to create checkbox


//       // pickType: Imag, // all/image/video
//     );


// }
}