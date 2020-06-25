import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gmfashions/api/models/product_details_response_model.dart';
import 'package:gmfashions/layouts/customer_review/customer_review_activity.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';
import 'package:gmfashions/widgets/server_error_widget.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CustomerReviewScreen extends StatefulWidget {
  final Rating rating;
  final String pId;

  CustomerReviewScreen({Key key, this.rating, this.pId}) : super(key: key);

  @override
  _CustomerReviewScreenState createState() => _CustomerReviewScreenState();
}

class _CustomerReviewScreenState extends CustomerReviewActivity {
  @override
  void initState() {
    onInitState(widget.pId);
    super.initState();
  }

  @override
  void dispose() {
    msgCntlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer Reviews',
          style: logoWhiteStyle(context),
        ),
        backgroundColor: red1,
        centerTitle: true,
      ),
      body: StreamBuilder<ReviewListState>(
          stream: reviewCtr.stream,
          initialData: ReviewListState.LOADING,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case ReviewListState.IDLE:
                return reviewIdleState(context);
                break;
              case ReviewListState.LOADING:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ReviewListState.EMPTY:
                return Center(
                    child: Text(
                  'No Reviews',
                  style: TextStyle(fontSize: 16, color: grey),
                ));
                break;
              case ReviewListState.ERROR:
                return ServerErrorWidget();
                break;
              default:
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          }),
      floatingActionButton: FloatingActionButton(
        heroTag: 'review',
        elevation: 0,
        child: Icon(Icons.add),
        onPressed: () {
          reviewDialog(context);
        },
      ),
    );
  }

  /// submit review dialog

  void reviewDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            title: Text('Write a Review'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
                textColor: red1,
              ),
              FlatButton(
                onPressed: () {
                  postReview();
                },
                child: Text('Submit'),
                textColor: red1,
              )
            ],
            content: Form(
              key: reviewMsgFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Rate us'),
                  SizedBox(
                    height: 10,
                  ),
                  StreamBuilder<double>(
                      stream: ratingCntlr.stream,
                      initialData: 0.0,
                      builder: (context, snapshot) {
                        return SmoothStarRating(
                          onRatingChanged: ratingChange,
                          starCount: 5,
                          rating: snapshot.data,
                          size: context.scale(35),
                          color: orange,
                          borderColor: orange,
                        );
                      }),
                  SizedBox(
                    height: context.scale(10),
                  ),
                  TextFormField(
                    cursorColor: red1,
                    controller: msgCntlr,
                    decoration: InputDecoration(
                      hintText: 'Enter your Message',
                    ),
                    maxLines: 3,
                    onSaved: (val) {
                      msgCntlr.text = val;
                    },
                    validator: (val) =>
                        val.isEmpty ? 'Enter Review Message' : null,
//                    minLines: 3,
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// idle state stream builder
  Column reviewIdleState(BuildContext context) {
    return Column(
      children: <Widget>[
        ratingCard(context),
        Expanded(
          child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                    height: context.scale(10),
                  ),
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                String description = reviewList[index].text;
                String author = reviewList[index].author;
                DateTime date = reviewList[index].dateAdded;
                double rating = double.parse(reviewList[index].rating);
                return customerReviewListItem(
                    context, description, author, date, rating);
              },
              itemCount: reviewList.length),
        )
      ],
    );
  }

  /// show reviews & rating text
  Padding ratingCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: SizedBox(
        height: context.scale(50),
        child: Card(
          color: orange,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.rating.rating.substring(0, 3),
                style: headingTxt(20, context, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: context.scale(15),
              ),
              SmoothStarRating(
                allowHalfRating: false,
                starCount: 5,
                rating: double.parse(widget.rating.rating.substring(0, 4)),
                size: context.scale(14),
                color: red,
                borderColor: red,
              ),
              SizedBox(
                width: context.scale(8),
              ),
              Text(
                '${widget.rating.total} Review${widget.rating.total == '1' ? '' : 's'}',
                style: TextStyle(color: black),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// customer review list items

  Widget customerReviewListItem(BuildContext context, String description,
      String author, DateTime date, double rate) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: context.scale(10),
            ),
            Text(author,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
            SizedBox(
              height: context.scale(5),
            ),
            Row(
              children: <Widget>[
                SmoothStarRating(
                  allowHalfRating: false,
                  starCount: 5,
                  rating: rate,
                  size: context.scale(20),
                  color: orange,
                  borderColor: orange,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  DateFormat('dd MMM').format(date),
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(description),
          ],
        ),
      ),
    );
  }
}
