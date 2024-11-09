import 'dart:convert';

CheckoutDto checkoutDtoFromJson(String str) => CheckoutDto.fromJson(json.decode(str));

String checkoutDtoToJson(CheckoutDto data) => json.encode(data.toJson());

class CheckoutDto {
  final String? link;
  final String? requestId;

  CheckoutDto({
    this.link,
    this.requestId,
  });

  factory CheckoutDto.fromJson(Map<String, dynamic> json) => CheckoutDto(
        link: json["link"],
        requestId: json["requestId"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "requestId": requestId,
      };
}
