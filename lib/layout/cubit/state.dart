import 'package:shopping_app/models/addAddress_model.dart';
import 'package:shopping_app/models/address_model.dart';
import 'package:shopping_app/models/change_fav.dart';
import 'package:shopping_app/models/getorder_model.dart';
import 'package:shopping_app/models/login_model.dart';
import 'package:shopping_app/models/updateAddress_model.dart';
import 'package:shopping_app/models/user_model.dart';

abstract class ShopLayoutStates{}
class ShopLayoutInitialStates extends ShopLayoutStates{}
class ShopLayoutChangeNavBarStates extends ShopLayoutStates{}
class ShopLayoutLoadingStates extends ShopLayoutStates{}
class ShopLayoutSuccessStates extends ShopLayoutStates{}
class ShopLayoutErrorStates extends ShopLayoutStates{
  final String error;
  ShopLayoutErrorStates(this.error);
}
class ShopLayoutLoadingCatStates extends ShopLayoutStates{}
class ShopLayoutSuccessCatStates extends ShopLayoutStates{}
class ShopLayoutErrorCatStates extends ShopLayoutStates{
  final String error;
  ShopLayoutErrorCatStates(this.error);
}
class ShopLayoutLoadingChangeFavStates extends ShopLayoutStates{}
class ShopLayoutSuccessChangeFavStates extends ShopLayoutStates{
  final ChangeFavorites changeFavorites;

  ShopLayoutSuccessChangeFavStates(this.changeFavorites);
}
class ShopLayoutErrorChangeFavStates extends ShopLayoutStates{
  final String error;
  ShopLayoutErrorChangeFavStates(this.error);
}
class ShopLayoutLoadingChangeCartStates extends ShopLayoutStates{}
class ShopLayoutSuccessChangeCartStates extends ShopLayoutStates{
  final ChangeFavorites changeFavorites;

  ShopLayoutSuccessChangeCartStates(this.changeFavorites);

}
class ShopLayoutErrorChangeCartStates extends ShopLayoutStates{
  final String error;
  ShopLayoutErrorChangeCartStates(this.error);
}

class ShopLayoutLoadingGetFavoriteStates extends ShopLayoutStates{}
class ShopLayoutSuccessGetFavoriteStates extends ShopLayoutStates{}
class ShopLayoutErrorGetFavoriteStates extends ShopLayoutStates{
  final String error;
  ShopLayoutErrorGetFavoriteStates(this.error);
}
class ShopLayoutLoadingGetCartsStates extends ShopLayoutStates{}
class ShopLayoutSuccessGetCartsStates extends ShopLayoutStates{}
class ShopLayoutErrorGetCartsStates extends ShopLayoutStates{
  final String error;
  ShopLayoutErrorGetCartsStates(this.error);
}
class ShopLayoutLoadingGetProductsDetailsStates extends ShopLayoutStates{}
class ShopLayoutSuccessGetProductsDetailsStates extends ShopLayoutStates{}
class ShopLayoutErrorGetProductsDetailsStates extends ShopLayoutStates{
  final String error;
  ShopLayoutErrorGetProductsDetailsStates(this.error);
}
class ShopLayoutLoadingGetCategoriesDetailsStates extends ShopLayoutStates{}
class ShopLayoutSuccessGetCategoriesDetailsStates extends ShopLayoutStates{}
class ShopLayoutErrorGetCategoriesDetailsStates extends ShopLayoutStates{
  final String error;
  ShopLayoutErrorGetCategoriesDetailsStates(this.error);
}

class ShopPlusQuantityState extends ShopLayoutStates{}
class ShopMinusQuantityState extends ShopLayoutStates{}
class ShopSuccessCountCartState extends ShopLayoutStates{}
class ShopErrorCountCartState extends ShopLayoutStates{
  final String error;

  ShopErrorCountCartState(this.error);
}
class ShopLayoutLoadingAddAddressStates extends ShopLayoutStates{}
class ShopLayoutSuccessAddAddressStates extends ShopLayoutStates{
final AddAddressModel addAddressModel;

  ShopLayoutSuccessAddAddressStates(this.addAddressModel);
}
class ShopLayoutErrorAddAddressStates extends ShopLayoutStates {
  final String error;

  ShopLayoutErrorAddAddressStates(this.error);
}

class ShopLayoutLoadingGetAddressStates extends ShopLayoutStates{}
class ShopLayoutSuccessGetAddressStates extends ShopLayoutStates{}
class ShopLayoutErrorGetAddressStates extends ShopLayoutStates {
  final String error;

  ShopLayoutErrorGetAddressStates(this.error);
}
class ShopLayoutLoadingUpDateAddressStates extends ShopLayoutStates{}
class ShopLayoutSuccessUpDateAddressStates extends ShopLayoutStates{
  final UpDateAddressModel upDateAddressModel;

  ShopLayoutSuccessUpDateAddressStates(this.upDateAddressModel);
}
class ShopLayoutErrorUpDateAddressStates extends ShopLayoutStates {
  final String error;

  ShopLayoutErrorUpDateAddressStates(this.error);
}
class ShopLayoutLoadingDeleteAddressStates extends ShopLayoutStates{}
class ShopLayoutSuccessDeleteAddressStates extends ShopLayoutStates{}
class ShopLayoutErrorDeleteAddressStates extends ShopLayoutStates {
  final String error;

  ShopLayoutErrorDeleteAddressStates(this.error);
}
class ShopLoadingGetOrdersState extends ShopLayoutStates{}
class ShopLayoutSuccessGetOrdersStates extends ShopLayoutStates{}
class ShopLayoutErrorGetOrdersStates extends ShopLayoutStates {
  final String error;

  ShopLayoutErrorGetOrdersStates(this.error);
}

class ShopLoadingCancelOrdersState extends ShopLayoutStates{}
class ShopLayoutSuccessCancelStates extends ShopLayoutStates{}
class ShopLayoutErrorCancelOrdersStates extends ShopLayoutStates {
  final String error;

  ShopLayoutErrorCancelOrdersStates(this.error);
}

class ShopLoadingAddOrdersState extends ShopLayoutStates{}
class ShopLayoutSuccessAddOrdersStates extends ShopLayoutStates{
  final AddOrderModel addOrderModel;

  ShopLayoutSuccessAddOrdersStates(this.addOrderModel);
}
class ShopLayoutErrorAddOrdersStates extends ShopLayoutStates {
  final String error;

  ShopLayoutErrorAddOrdersStates(this.error);
}



class ShopLayoutLoadingGetUserDataStates extends ShopLayoutStates{}
class ShopLayoutSuccessGetUserDataStates extends ShopLayoutStates{}
class ShopLayoutErrorGetUserDataStates extends ShopLayoutStates{
  final String error;
  ShopLayoutErrorGetUserDataStates(this.error);
}
class ShopLayoutLoadingLogOutStates extends ShopLayoutStates{}
class ShopLayoutSuccessLogOutStates extends ShopLayoutStates{}
class ShopLayoutErrorLogOutStates extends ShopLayoutStates{
  final String error;
  ShopLayoutErrorLogOutStates(this.error);
}


class ShopLayoutLoadingUpDateProfileStates extends ShopLayoutStates{}
class ShopLayoutSuccessUpDateProfileStates extends ShopLayoutStates{
  final LogoutModel loginModel;

  ShopLayoutSuccessUpDateProfileStates(this.loginModel);
}
class ShopLayoutErrorUpDateProfileStates extends ShopLayoutStates{
  final String error;
  ShopLayoutErrorUpDateProfileStates(this.error);
}

class ShopLayoutChangeSuffixStates extends ShopLayoutStates{}

class ShopLayoutLoadingGetFaqsStates extends ShopLayoutStates{}
class ShopLayoutSuccessGetFaqsStates extends ShopLayoutStates{}
class ShopLayoutErrorGetFaqsStates extends ShopLayoutStates{
  final String error;
  ShopLayoutErrorGetFaqsStates(this.error);
}

class ShopLayoutChangeExpansionIconStates extends ShopLayoutStates{}
