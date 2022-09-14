import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Modules/address/AddAddress.dart';
import 'package:shopping_app/Modules/address/getAddress.dart';
import 'package:shopping_app/Modules/carts/carts_screen.dart';
import 'package:shopping_app/Modules/categories/categories_screen.dart';
import 'package:shopping_app/Modules/favorites/favorites_screen.dart';
import 'package:shopping_app/Modules/orders/orders.dart';
import 'package:shopping_app/Modules/products/products_screen.dart';
import 'package:shopping_app/components/constance.dart';
import 'package:shopping_app/layout/cubit/state.dart';
import 'package:shopping_app/models/addAddress_model.dart';
import 'package:shopping_app/models/address_model.dart';
import 'package:shopping_app/models/carts_model.dart';
import 'package:shopping_app/models/categories_details.dart';
import 'package:shopping_app/models/categories_model.dart';
import 'package:shopping_app/models/change_fav.dart';
import 'package:shopping_app/models/faqs_model.dart';
import 'package:shopping_app/models/favorite_model.dart';
import 'package:shopping_app/models/getorder_model.dart';
import 'package:shopping_app/models/home_model.dart';
import 'package:shopping_app/models/product_details.dart';
import 'package:shopping_app/models/updateAddress_model.dart';
import 'package:shopping_app/models/user_model.dart';
import 'package:shopping_app/shared/end_points.dart';
import 'package:shopping_app/shared/network/dio_helper.dart';
import 'package:shopping_app/shared/remote/cache_helper.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates> {
  ShopLayoutCubit() : super(ShopLayoutInitialStates());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    CartsScreen(),
    AddressesScreen(),
    OrderScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ShopLayoutChangeNavBarStates());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  Map<int, bool> carts = {};

  void getHomeData() {
    emit(ShopLayoutLoadingStates());
    DioHelper.getData(
        url: HOME,
        token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id!: element.in_favorites!
        });
      });
      homeModel!.data!.products.forEach((element) {
        carts.addAll({
          element.id!: element.in_cart!
        });
      });
      emit(ShopLayoutSuccessStates());
    }).catchError((error) {
      emit(ShopLayoutErrorStates(error.toString()));
      print(error.toString());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    emit(ShopLayoutLoadingCatStates());
    DioHelper.getData(
        url: GET_CATEGORIES,
        token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopLayoutSuccessCatStates());
    }).catchError((error) {
      emit(ShopLayoutErrorCatStates(error.toString()));
      print(error.toString());
    });
  }

  ChangeFavorites? changeFavorites;

  void changeFavorite(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopLayoutLoadingChangeFavStates());
    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id': productId
        },
        token: token).then((value) {
      changeFavorites = ChangeFavorites.fromJson(value.data);
      if (!changeFavorites!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorite();
      }
      print(value.data);
      emit(ShopLayoutSuccessChangeFavStates(changeFavorites!));
    }).catchError((error) {
      emit(ShopLayoutErrorChangeFavStates(error.toString()));
      print(error.toString());
    });
  }

  void changeCart(int productId) {
    carts[productId] = !carts[productId]!;
    emit(ShopLayoutLoadingChangeCartStates());
    DioHelper.postData(
        url: CARTS,
        data: {
          'product_id': productId
        },
        token: token).then((value) {
      changeFavorites = ChangeFavorites.fromJson(value.data);
      if (!changeFavorites!.status!) {
        carts[productId] = !carts[productId]!;
      } else {
        getCart();
      }
      emit(ShopLayoutSuccessChangeCartStates(changeFavorites!));
    }).catchError((error) {
      emit(ShopLayoutErrorChangeCartStates(error.toString()));
      print(error.toString());
    });
  }

  FavoriteModel? favoriteModel;

  void getFavorite() {
    emit(ShopLayoutLoadingGetFavoriteStates());
    DioHelper.getData(
        url: FAVORITES,
        token: token).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(ShopLayoutSuccessGetFavoriteStates());
    }).catchError((error) {
      emit(ShopLayoutErrorGetFavoriteStates(error.toString()));
      print(error.toString());
    });
  }

  CartModel? cartModel;

  void getCart() {
    emit(ShopLayoutLoadingCatStates());
    DioHelper.getData(
      url: CARTS,
      token: token,
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(ShopLayoutSuccessGetCartsStates());
    }).catchError((error) {
      print('ERROR CARTS ' + error.toString());
      emit(ShopLayoutErrorGetCartsStates(error.toString()));
    });
  }

  ProductDetailsModel? productDetailsModel;

  void getProductDetails(int productId) {
    emit(ShopLayoutLoadingGetProductsDetailsStates());
    DioHelper.getData(
      url: PRODUCTDETAILS + productId.toString(),
      token: token,
    ).then(
          (value) {
        productDetailsModel = ProductDetailsModel.fromJson(value.data);
        emit(ShopLayoutSuccessGetProductsDetailsStates());
      },
    ).catchError(
          (error) {
        emit(ShopLayoutErrorGetProductsDetailsStates(error.toString()));
        print('ERROR PRODUCT DETAILS' + error.toString());
      },
    );
  }

  CategoryDetailModel? categoryDetailModel;

  void getCategoriesDetails(int categoryId) {
    emit(ShopLayoutLoadingGetCategoriesDetailsStates());

    DioHelper.getData(
        url: CATEGORYDETAILS + categoryId.toString(),
        token: token
    ).then((value) {
      categoryDetailModel = CategoryDetailModel.fromJson(value.data);
      emit(ShopLayoutSuccessGetCategoriesDetailsStates());
    }).catchError((error) {
      emit(ShopLayoutErrorGetCategoriesDetailsStates(error.toString()));
      print(error.toString());
    });
  }

  int quantity = 1;

  void plusQuantity(CartModel model, index) {
    quantity = model.data!.cartItems![index].quantity!;
    quantity++;
    emit(ShopPlusQuantityState());
  }

  void minusQuantity(CartModel model, index) {
    quantity = model.data!.cartItems![index].quantity!;
    if (quantity > 1) quantity--;
    emit(ShopMinusQuantityState());
  }

  void updateCartData({
    required String id,
    int? quantity,
  }) {
    DioHelper.putData(
        url: '${UPDATECARTS + id}',
        data: {
          'quantity': quantity,
        },
        token: token
    ).then((value) {
      emit(ShopSuccessCountCartState());
      getCart();
    }).catchError((error) {
      emit(ShopErrorCountCartState(error.toString()));
      print(error.toString());
    });
  }

  AddAddressModel? addAddressModel;

  void addAddress({
    required String name,
    required String city,
    required String region,
    required String details,
    required String notes,
    double latitude = 30.0616863,
    double longitude = 31.3260088,
  }) {
    emit(ShopLayoutLoadingAddAddressStates());

    DioHelper.postData(
        url: ADDRESS,
        data: {
          'name': name,
          'city': city,
          'region': region,
          'details': details,
          'notes': notes,
          'latitude': latitude,
          'longitude': longitude,
        },
        token: token).then((value) {
      addAddressModel = AddAddressModel.fromJson(value.data);
      print(value.data);
      emit(ShopLayoutSuccessAddAddressStates(addAddressModel!));
    }).catchError((error) {
      emit(ShopLayoutErrorAddAddressStates(error.toString()));
      print(error.toString());
    });
  }

  AddressModel? addressModel;

  void getAddress() {
    emit(ShopLayoutLoadingGetAddressStates());
    DioHelper.getData(
        url: ADDRESS,
        token: token).then((value) {
      addressModel = AddressModel.fromJson(value.data);
      print(value.data);
      emit(ShopLayoutSuccessGetAddressStates());
    }).catchError((error) {
      emit(ShopLayoutErrorGetAddressStates(error.toString()));
      print(error.toString());
    });
  }

  UpDateAddressModel? updateAddressModel;

  void updateAddress({
    required int ?addressId,
    required String name,
    required String city,
    required String region,
    required String details,
    required String notes,
    double latitude = 30.0616863,
    double longitude = 31.3260088,
  }) {
    emit(ShopLayoutLoadingUpDateAddressStates());
    DioHelper.putData(
        url: 'addresses/$addressId',
        token: token,
        data: {
          'name': name,
          'city': city,
          'region': region,
          'details': details,
          'notes': notes,
          'latitude': latitude,
          'longitude': longitude,
        }
    ).then((value) {
      updateAddressModel = UpDateAddressModel.fromJson(value.data);
      if (updateAddressModel!.status!)
        getAddress();
      emit(ShopLayoutSuccessUpDateAddressStates(updateAddressModel!));
    }).catchError((error) {
      emit(ShopLayoutErrorUpDateAddressStates(error.toString()));
      print(error.toString());
    });
  }

  UpDateAddressModel? deleteAddressModel;

  void deleteAddress({required addressId}) {
    emit(ShopLayoutLoadingDeleteAddressStates());
    DioHelper.deleteData(
      url: 'addresses/$addressId',
      token: token,
    ).then((value) {
      deleteAddressModel = UpDateAddressModel.fromJson(value.data);
      if (deleteAddressModel!.status!)
        getAddress();
      emit(ShopLayoutSuccessDeleteAddressStates());
    }).catchError((error) {
      emit(ShopLayoutErrorDeleteAddressStates(error.toString()));
      print(error.toString());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLayoutLoadingGetUserDataStates());
    DioHelper.getData(
        url: PROFILE,
        token: token
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLayoutSuccessGetUserDataStates());
    }).catchError((error) {
      emit(ShopLayoutErrorGetUserDataStates(error.toString()));
      print(error.toString());
    });
  }

  LogoutModel? logoutModel;

  void logOutModel() {
    emit(ShopLayoutLoadingLogOutStates());
    DioHelper.postData(
        url: LOGOUT,
        data: {},
        token: token).then((value) {
      logoutModel = LogoutModel.fromJson(value.data);
      emit(ShopLayoutSuccessLogOutStates());
    }).catchError((error) {
      emit(ShopLayoutErrorLogOutStates(error.toString()));
      print(error.toString());
    });
  }

  void upDataProfile({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLayoutLoadingUpDateProfileStates());

    DioHelper.putData(
        url: UPDATE,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
        },
        token: token).then((value) {
      userModel!.status = value.data['status'];
      userModel!.message = value.data['message'];
      if (userModel!.status)
        userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLayoutSuccessUpDateProfileStates(logoutModel!));
    }).catchError((error) {
      emit(ShopLayoutErrorUpDateProfileStates(error.toString()));
      print(error.toString());
    });
  }

  FaqsModel? faqsModel;

  void getFaqs(){
    emit(ShopLayoutLoadingGetFaqsStates());
    DioHelper.getData(url: FAQS,).then((value) {
      faqsModel = FaqsModel.fromJson(value.data);
      print(value.data);
      emit(ShopLayoutSuccessGetFaqsStates());
    }).catchError((error){
      emit(ShopLayoutErrorGetFaqsStates(error.toString()));
      print(error.toString());
    });
  }

  bool expansionIcon = false;
  void changeExpansionIcon(bool value){
    expansionIcon = value;
    emit(ShopLayoutChangeExpansionIconStates());
  }

  GetOrdersModel? getOrdersModel;
  void getOrders(){
    emit(ShopLoadingGetOrdersState());
    DioHelper.getData(
        url: ORDER,
        token: token).then((value) {
          getOrdersModel = GetOrdersModel.fromJson(value.data);
          print(value.data);
          emit(ShopLayoutSuccessGetOrdersStates());
    }).catchError((error){
      emit(ShopLayoutErrorGetOrdersStates(error.toString()));
      print(error.toString());
    });
  }

  void cancelOrder({required int id}){
    emit(ShopLoadingCancelOrdersState());
    DioHelper.getData(
        url: '${ORDER + id.toString()}',
    token: token).then((value) {
      emit(ShopLayoutSuccessCancelStates());
    }).catchError((error){
      emit(ShopLayoutErrorCancelOrdersStates(error.toString()));
      print(error.toString());
    });
  }

  int? addressId;
  AddOrderModel? addOrderModel;
  void addOrder(){
    emit(ShopLoadingAddOrdersState());
    DioHelper.postData(
        url: ORDER,
    data: {
      "address_id": addressId,
      "payment_method": 1,
      "use_points": false,
    },
    token: token).then((value) {
      addOrderModel = AddOrderModel.fromJson(value.data);
      print(value.data);
      if(addOrderModel!.status){
        getCart();
      }
      emit(ShopLayoutSuccessAddOrdersStates(addOrderModel!));
    }).catchError((error){

      emit(ShopLayoutErrorAddOrdersStates(error.toString()));
      print(error.toString());
    });
  }
}

