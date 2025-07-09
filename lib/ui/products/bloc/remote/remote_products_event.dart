
abstract class RemoteProductsEvent {
  const RemoteProductsEvent();
}

class GetProductsEvent extends RemoteProductsEvent {
  final String ? category;
  const GetProductsEvent({this.category});
}

class GetProductsCategoriesEvent extends RemoteProductsEvent {
  const GetProductsCategoriesEvent();
}

class GetProductDetailsEvent extends RemoteProductsEvent {
  final int id;
  const GetProductDetailsEvent({required this.id});
}