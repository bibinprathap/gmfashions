import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gmfashions/layouts/cart_list/cart_list_screen.dart';
import 'package:gmfashions/layouts/dashboard/dashboard_drawer.dart';
import 'package:gmfashions/layouts/productlist/product_list.dart';
import 'package:gmfashions/layouts/sub_category/sub_category_activity.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';
import 'package:gmfashions/widgets/server_error_widget.dart';

class SubCategoryScreen extends StatefulWidget {
  @required
  final String categoryId,name;
  final bool isUserNull;

  SubCategoryScreen({Key key, this.categoryId,this.name,this.isUserNull}) : super(key: key);

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends SubCategoryActivity {
  @override
  void initState() {
    subCategoryList(widget.categoryId);
//    tabController = new TabController(length: response.length, vsync: this);
//    tabController.addListener(onTabChange);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: DashboardDrawer(isUserNull: widget.isUserNull,),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: red1,
        title: Text(widget.name,style:  logoWhiteStyle(context),),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              scaffoldKey.currentState.openEndDrawer();
            },
            icon: Icon(
              Icons.menu,
              // size: context.scale(18),
              color: white,
            ),
          ),
        ],
      ),
//        appBar: appbar(context,
//            visibleCart: true,
//            flexibleSpace: TabBar(
//                labelColor: black,
//                controller: tabController,
//                tabs: response.map((subCategory) {
//                  return GestureDetector(
//                    onTap: (){
//                     // push(context: null, pushReplacement: null, toWidget: null)
//                    },
//                      child: Container(
//                    child: Text(
//                      subCategory.name,
//                      style:
//                          headingTxt(18, context, fontWeight: FontWeight.w600),
//                    ),
//                  ));
//                }).toList())),
        body: StreamBuilder<SubCategoryPageState>(
          stream: subCategoryController.stream,
          initialData: SubCategoryPageState.SUCCESS,
          builder: (context, snapshot) {
            switch(snapshot.data){
              case SubCategoryPageState.SUCCESS:
                return subCategoryIdleState();
                break;
              case SubCategoryPageState.LOADING:
                return loadingWidget(context);
                break;
              case SubCategoryPageState.ERROR:
                return ServerErrorWidget();
                break;
              case SubCategoryPageState.EMPTY:
                return Center(child: Text('List is Empty',style: disabledText(context, 16),));
                break;
              default:
                return Center(child: CircularProgressIndicator(),);
                break;
            }

          }
        ));
  }

  // grid view builder for subcategory

  Widget subCategoryIdleState() {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: response.length,
      itemBuilder: (BuildContext context, int index) {
    String product = response[index].name;
    String img =  response[index].image;
    String id =  response[index].categoryId;
        return subCategoryItem(context,product,img,id);
      },
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  // subCategory item

  Widget subCategoryItem(BuildContext context,String product,String img,String id) {
    return GestureDetector(
      onTap: (){
        navigateProductListScreen(context, id, product);

      },
      child: new Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(blurRadius: 2, color: black1)],
            color: Colors.white,
          ),
          child: Column(
           // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: imageWidget(width: context.scale(100),height: context.scale(100),imageURL: img),
              ),
              SizedBox(
                height: context.scale(10),
              ),
              Text(
                product,
                style: headingTxt(14, context,fontWeight: FontWeight.w600),
              ),
            ],
          )),
    );
  }



}
