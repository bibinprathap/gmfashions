import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gmfashions/api/models/home_response_model.dart';
import 'package:gmfashions/api/models/product_list_response_model.dart' as product;
import 'package:gmfashions/api/models/sub_category_response_model.dart' as sub;
import 'package:gmfashions/layouts/product_details/product_details.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';


class GridViewWidget extends StatefulWidget {

   //final String product,id,price,img;
  final List<LatestProduct> latestProduct;
//  final List<sub.Response> subCatList;
//  final List<product.Response> productList;
//  final bool isProductList;

  GridViewWidget({Key key,this.latestProduct}) : super(key: key);

  @override
  _GridViewWidgetState createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  @override
  Widget build(BuildContext context) {

    return gridViewBuilder();
  }

  StaggeredGridView gridViewBuilder() {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
//        String product =  widget.latestProduct[index].name;
//        String price =  widget.latestProduct[index].price;
//        String img =  widget.latestProduct[index].image;
//        String id =  widget.latestProduct[index].productId;
        return gridViewItem(context,'Shirts','1000','images/shirt1.jpg');
      },
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }


  Container gridViewItem(BuildContext context,String product,String price,String img) {
    return new Container(
        padding: EdgeInsets.all(8.0),
        // height: context.scale(300),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 2, color: black1)],
          color: Colors.white,
        ),
        child: Column(
//                                   // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: imageWidget(width: context.scale(140),height: context.scale(140),imageURL: img),
            ),
            SizedBox(
              height: context.scale(10),
            ),
            Text(
             product,
              style: disabledText(context, 14),
            ),
            Row(
              children: <Widget>[
                Text(
                  'Rs. $price/-',
                  style: headingTxt(14, context, fontWeight: FontWeight.w700),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: grey,
                  ),
                  onPressed: () {
                    //push(context: context, pushReplacement: false, toWidget: ProductDetails());
                  },
                  iconSize: 20,
                )
              ],
            )
          ],
        ));
  }

}