import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gmfashions/api/models/search_response_model.dart';
import 'package:gmfashions/layouts/search/search_product_activity.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';

class SearchProductScreen extends SearchProductActivity {
//  final bool isUserNull;
//  SearchProductScreen({ this.isUserNull}) ;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.keyboard_backspace));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) getSearchList(query);
    return StreamBuilder<SearchListChangeState>(
      stream: searchCtr.stream,
      initialData: SearchListChangeState.IDLE,
      builder: (context, snapshot) {
        switch(snapshot.data){
          case SearchListChangeState.IDLE:
            return searchIdleState();

            break;
          case SearchListChangeState.LOADING:
            return Center(child: CircularProgressIndicator(),);
            break;
          case SearchListChangeState.ERROR:
            return Center(child: Text('Something Wrong!',style: headingTxt(16, context),),);
            break;
          case SearchListChangeState.EMPTY:
            return Center(child: Text('List is Empty',style: headingTxt(16, context),),);
            break;
          default:
            return Center(child: CircularProgressIndicator(),);

        }
      }
    );
  }

  // search list idle state

  ListView searchIdleState() {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: searchList.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              navigateProductDetails(
                  context, searchList[index].name, searchList[index].productId,searchList[index].price);
            },
            leading: SizedBox(
                width: context.scale(100),
                height: context.scale(100),
                child: imageWidget(
                    width: context.scale(100),
                    height: context.scale(100),
                    imageURL: searchList[index].image)
            ),
            title:
            Text(searchList[index].name, style: headingTxt(14, context,fontWeight: FontWeight.w500),),
            subtitle: Text(
              'Rs ${searchList[index].price.replaceAll('.0000', '')} /-',
              style: headingTxt(14, context),
            ),
          );
        });
  }
}
