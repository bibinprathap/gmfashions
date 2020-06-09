import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gmfashions/layouts/dashboard/dashboard_drawer.dart';
import 'package:gmfashions/layouts/product_details/product_details.dart';
import 'package:gmfashions/layouts/productlist/product_activity.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';
import 'package:gmfashions/widgets/server_error_widget.dart';

class ProductList extends StatefulWidget {
  final String id, name;
  final bool isUserNull;

  ProductList({Key key, this.name, this.id, this.isUserNull}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends ProductActivity {
  @override
  void initState() {
    getProductList(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: DashboardDrawer(
        isUserNull: widget.isUserNull,
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: red1,
        title: Text(
          widget.name,
          style: logoWhiteStyle(context),
        ),
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
      body: StreamBuilder<ProductListChangeState>(
          stream: productListCtr.stream,
          initialData: ProductListChangeState.LOADING,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case ProductListChangeState.SUCCESS:
                return gridViewBuilder(context);
                break;
              case ProductListChangeState.LOADING:
                return loadingWidget(context);
                break;
              case ProductListChangeState.EMPTY:
                return Center(
                    child: Text(
                  'List Empty',
                  style: headingTxt(20, context),
                ));
                break;
              case ProductListChangeState.ERROR:
                return ServerErrorWidget();
                break;
              default:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
            }
          }),
    );
  }



  Widget gridViewBuilder(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: product.length,
        itemBuilder: (BuildContext context, int index) {
          String productName = product[index].name;
          String productId = product[index].productId;
          String price = product[index].price;
          String image = product[index].image;
          return gridViewItem(context, productName, price, image, productId);
        },
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }

  // latest product items

  Widget gridViewItem(BuildContext context, String product, String price,
      String img, String id) {
    return GestureDetector(
      onTap: () {
        navigateProductDetails(context, id, product, price);
      },
      child: new Container(
          padding: EdgeInsets.all(8.0),
          // height: context.scale(300),
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(blurRadius: 2, color: black1)],
            color: white,
          ),
          child: Column(
//                                  // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: imageWidget(
                    width: context.scale(140),
                    height: context.scale(140),
                    imageURL: img),
              ),
              SizedBox(
                height: context.scale(10),
              ),
              Text(
                product,
                style: disabledText(context, 14),
              ),
              SizedBox(
                height: context.scale(5),
              ),
              Text(
                'Rs. ${price.replaceAll('.00', '')} /-',
                style: headingTxt(14, context, fontWeight: FontWeight.w700),
              ),
//            Row(
//              children: <Widget>[
//                Text(
//                  'Rs. $price/-',
//                  style: headingTxt(14, context, fontWeight: FontWeight.w700),
//                ),
//                Spacer(),
//                IconButton(
//                  icon: Icon(
//                    Icons.shopping_cart,
//                    color: grey,
//                  ),
//                  onPressed: () {
//                    push(context: context, pushReplacement: false, toWidget: ProductDetails());
//                  },
//                  iconSize: 20,
//                )
//              ],
//            )
            ],
          )),
    );
  }
}
