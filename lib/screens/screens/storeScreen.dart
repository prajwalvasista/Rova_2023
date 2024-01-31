import 'package:flutter/material.dart';
import 'package:rova_23/controllers/ShopsController.dart';
import 'package:rova_23/models/ShopsModel.dart';

class StoreScreen extends StatelessWidget {
  ShopsController _shopsController = ShopsController();
  ShopsModel _shopsModel = ShopsModel();
  var shopList;
  List<Widget> containerList = [];

  Future<void> _getShopDetails() async {
    _shopsModel.city = "Bengaluru";
    var result = await _shopsController.getShopDetails(_shopsModel);
    shopList = result["data"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Nearby store',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 30,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w500,
                  height: 05,
                ),
              ),
              SizedBox(height: 30), // Spacer
              FutureBuilder(
                future: _getShopDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      containerList.clear();
                      for (int i = 0; i < shopList.length; i++) {
                        containerList.add(buildContainer(
                            "images/stock${i + 1}.png",
                            "${shopList[i]["shop_Name"]}",
                            "${shopList[i]["shop_Address"]}"));
                      }
                      return Column(
                        children: containerList,
                      );
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContainer(
      String imagePath, String storeName, String storeAddress) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 95,
            height: 96,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  storeName,
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 22,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  storeAddress,
                  style: TextStyle(
                    color: Color(0xFF6D6D6D),
                    fontSize: 10,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/Group 27.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/map 1.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: StoreScreen(),
  ));
}
