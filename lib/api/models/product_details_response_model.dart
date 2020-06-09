// To parse this JSON data, do
//
//     final productDetailResponse = productDetailResponseFromJson(jsonString);

import 'dart:convert';

ProductDetailResponse productDetailResponseFromJson(String str) => ProductDetailResponse.fromJson(json.decode(str));

String productDetailResponseToJson(ProductDetailResponse data) => json.encode(data.toJson());

class ProductDetailResponse {
  Response response;
  int success;
  String message;

  ProductDetailResponse({
    this.response,
    this.success,
    this.message,
  });

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) => new ProductDetailResponse(
    response: json["response"] == null ? null : Response.fromJson(json["response"]),
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "response": response == null ? null : response.toJson(),
    "success": success == null ? null : success,
    "message": message == null ? null : message,
  };
}

class Response {
  List<BasicDetail> basicDetails;
  List<ImageDetail> imageDetails;
  List<Option> options;
  List<Special> special;
  List<Review> review;
  List<Rating> rating;
  List<RelatedProduct> relatedProduct;

  Response({
    this.basicDetails,
    this.imageDetails,
    this.options,
    this.special,
    this.review,
    this.rating,
    this.relatedProduct,
  });

  factory Response.fromJson(Map<String, dynamic> json) => new Response(
    basicDetails: json["basic_details"] == 0 ? null : new List<BasicDetail>.from(json["basic_details"].map((x) => BasicDetail.fromJson(x))),
    imageDetails: json["image_details"] == 0 ? null : new List<ImageDetail>.from(json["image_details"].map((x) => ImageDetail.fromJson(x))),
    options: json["options"] == [] ? null : new List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
    special: json["special"] == false ? null : new List<Special>.from(json["special"].map((x) => Special.fromJson(x))),
    review: json["review"] == false ? null : new List<Review>.from(json["review"].map((x) => Review.fromJson(x))),
    rating: json["rating"] == false ? null : new List<Rating>.from(json["rating"].map((x) => Rating.fromJson(x))),
    relatedProduct: json["related_product"] == false ? null : new List<RelatedProduct>.from(json["related_product"].map((x) => RelatedProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "basic_details": basicDetails == null ? null : new List<dynamic>.from(basicDetails.map((x) => x.toJson())),
    "image_details": imageDetails == null ? null : new List<dynamic>.from(imageDetails.map((x) => x.toJson())),
    "options": options == null ? null : new List<dynamic>.from(options.map((x) => x.toJson())),
    "special": special == null ? null : new List<dynamic>.from(special.map((x) => x.toJson())),
    "review": review == null ? null : new List<dynamic>.from(review.map((x) => x.toJson())),
    "rating": rating == null ? null : new List<dynamic>.from(rating.map((x) => x.toJson())),
    "related_product": relatedProduct == null ? null : new List<dynamic>.from(relatedProduct.map((x) => x.toJson())),
  };
}

class BasicDetail {
  String sizeChartImage;
  String sizeChartDescription;
  String productId;
  String quantity;
  String image;
  String price;
  String name;

  BasicDetail({
    this.sizeChartImage,
    this.sizeChartDescription,
    this.productId,
    this.quantity,
    this.image,
    this.price,
    this.name,
  });

  factory BasicDetail.fromJson(Map<String, dynamic> json) => new BasicDetail(
    sizeChartImage: json["size_chart_image"] == null ? null : json["size_chart_image"],
    sizeChartDescription: json["size_chart_description"] == null ? null : json["size_chart_description"],
    productId: json["product_id"] == null ? null : json["product_id"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    image: json["image"] == null ? null : json["image"],
    price: json["price"] == null ? null : json["price"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "size_chart_image": sizeChartImage == null ? null : sizeChartImage,
    "size_chart_description": sizeChartDescription == null ? null : sizeChartDescription,
    "product_id": productId == null ? null : productId,
    "quantity": quantity == null ? null : quantity,
    "image": image == null ? null : image,
    "price": price == null ? null : price,
    "name": name == null ? null : name,
  };
}

class ImageDetail {
  String image;

  ImageDetail({
    this.image,
  });

  factory ImageDetail.fromJson(Map<String, dynamic> json) => new ImageDetail(
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "image": image == null ? null : image,
  };
}

class Option {
  String productOptionId;
  String optionId;
  String name;
  String type;
  String value;
  String required;
  List<ProductOptionValue> productOptionValue;

  Option({
    this.productOptionId,
    this.optionId,
    this.name,
    this.type,
    this.value,
    this.required,
    this.productOptionValue,
  });

  factory Option.fromJson(Map<String, dynamic> json) => new Option(
    productOptionId: json["product_option_id"] == null ? null : json["product_option_id"],
    optionId: json["option_id"] == null ? null : json["option_id"],
    name: json["name"] == null ? null : json["name"],
    type: json["type"] == null ? null : json["type"],
    value: json["value"] == null ? null : json["value"],
    required: json["required"] == null ? null : json["required"],
    productOptionValue: json["product_option_value"] == null ? null : new List<ProductOptionValue>.from(json["product_option_value"].map((x) => ProductOptionValue.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product_option_id": productOptionId == null ? null : productOptionId,
    "option_id": optionId == null ? null : optionId,
    "name": name == null ? null : name,
    "type": type == null ? null : type,
    "value": value == null ? null : value,
    "required": required == null ? null : required,
    "product_option_value": productOptionValue == null ? null : new List<dynamic>.from(productOptionValue.map((x) => x.toJson())),
  };
}

class ProductOptionValue {
  String productOptionId;
  String productOptionValueId;
  String name;
  String image;
  String quantity;
  String subtract;
  String price;
  String pricePrefix;
  String weight;
  String weightPrefix;
  bool isSelected;

  ProductOptionValue({
    this.productOptionId,
    this.productOptionValueId,
    this.name,
    this.image,
    this.quantity,
    this.subtract,
    this.price,
    this.pricePrefix,
    this.weight,
    this.weightPrefix,
    this.isSelected,
  });

  factory ProductOptionValue.fromJson(Map<String, dynamic> json) => new ProductOptionValue(
    productOptionId: json["product_option_id"] == null ? null : json["product_option_id"],
    productOptionValueId: json["product_option_value_id"] == null ? null : json["product_option_value_id"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    subtract: json["subtract"] == null ? null : json["subtract"],
    price: json["price"] == null ? null : json["price"],
    pricePrefix: json["price_prefix"] == null ? null : json["price_prefix"],
    weight: json["weight"] == null ? null : json["weight"],
    weightPrefix: json["weight_prefix"] == null ? null : json["weight_prefix"],
    isSelected: json["price"] == null ? null : false,
  );

  Map<String, dynamic> toJson() => {
    "product_option_id": productOptionId == null ? null : productOptionId,
    "product_option_value_id": productOptionValueId == null ? null : productOptionValueId,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
    "quantity": quantity == null ? null : quantity,
    "subtract": subtract == null ? null : subtract,
    "price": price == null ? null : price,
    "price_prefix": pricePrefix == null ? null : pricePrefix,
    "weight": weight == null ? null : weight,
    "weight_prefix": weightPrefix == null ? null : weightPrefix,
  };
}

class Rating {
  String rating;
  String total;

  Rating({
    this.rating,
    this.total,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => new Rating(
    rating: json["rating"] == null ? null : json["rating"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "rating": rating == null ? null : rating,
    "total": total == null ? null : total,
  };
}

class RelatedProduct {
  String productId;
  String name;
  String price;
  String image;

  RelatedProduct({
    this.productId,
    this.name,
    this.price,
    this.image,
  });

  factory RelatedProduct.fromJson(Map<String, dynamic> json) => new RelatedProduct(
    productId: json["product_id"] == null ? null : json["product_id"],
    name: json["name"] == null ? null : json["name"],
    price: json["price"] == null ? null : json["price"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId == null ? null : productId,
    "name": name == null ? null : name,
    "price": price == null ? null : price,
    "image": image == null ? null : image,
  };
}

class Review {
  String author;
  String text;
  String rating;
  DateTime dateAdded;

  Review({
    this.author,
    this.text,
    this.rating,
    this.dateAdded,
  });

  factory Review.fromJson(Map<String, dynamic> json) => new Review(
    author: json["author"] == null ? null : json["author"],
    text: json["text"] == null ? null : json["text"],
    rating: json["rating"] == null ? null : json["rating"],
    dateAdded: json["date_added"] == null ? null : DateTime.parse(json["date_added"]),
  );

  Map<String, dynamic> toJson() => {
    "author": author == null ? null : author,
    "text": text == null ? null : text,
    "rating": rating == null ? null : rating,
    "date_added": dateAdded == null ? null : dateAdded.toIso8601String(),
  };
}

class Special {
  String productSpecialId;
  String productId;
  String customerGroupId;
  String priority;
  String price;
  DateTime dateStart;
  DateTime dateEnd;

  Special({
    this.productSpecialId,
    this.productId,
    this.customerGroupId,
    this.priority,
    this.price,
    this.dateStart,
    this.dateEnd,
  });

  factory Special.fromJson(Map<String, dynamic> json) => new Special(
    productSpecialId: json["product_special_id"] == null ? null : json["product_special_id"],
    productId: json["product_id"] == null ? null : json["product_id"],
    customerGroupId: json["customer_group_id"] == null ? null : json["customer_group_id"],
    priority: json["priority"] == null ? null : json["priority"],
    price: json["price"] == null ? null : json["price"],
    dateStart: json["date_start"] == null ? null : DateTime.parse(json["date_start"]),
    dateEnd: json["date_end"] == null ? null : DateTime.parse(json["date_end"]),
  );

  Map<String, dynamic> toJson() => {
    "product_special_id": productSpecialId == null ? null : productSpecialId,
    "product_id": productId == null ? null : productId,
    "customer_group_id": customerGroupId == null ? null : customerGroupId,
    "priority": priority == null ? null : priority,
    "price": price == null ? null : price,
    "date_start": dateStart == null ? null : "${dateStart.year.toString().padLeft(4, '0')}-${dateStart.month.toString().padLeft(2, '0')}-${dateStart.day.toString().padLeft(2, '0')}",
    "date_end": dateEnd == null ? null : "${dateEnd.year.toString().padLeft(4, '0')}-${dateEnd.month.toString().padLeft(2, '0')}-${dateEnd.day.toString().padLeft(2, '0')}",
  };
}
