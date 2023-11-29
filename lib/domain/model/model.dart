class SliderObject {
  String title;
  String subtitle;
  String image;
  SliderObject(this.title, this.subtitle, this.image);
}

class Customer {
  String id;

  String name;

  int countOfNotification;

  Customer(this.id, this.name, this.countOfNotification);
}

class Content {
  String email;

  String link;

  String phone;

  Content(this.phone, this.email, this.link);
}

class Authentication {
  Content? content;

  Customer? customer;

  Authentication(this.customer, this.content);
}

class DeviceInfo {
  String name;
  String identifier;
  String version;

  DeviceInfo(this.name, this.identifier, this.version);
}
