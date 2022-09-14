import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Modules/ChangeMode/Changemode.dart';
import 'package:shopping_app/Modules/change_password/change_password.dart';
import 'package:shopping_app/Modules/login/login_screen.dart';
import 'package:shopping_app/Modules/profile/profile.dart';
import 'package:shopping_app/Modules/search/search.dart';
import 'package:shopping_app/components/components.dart';
import 'package:shopping_app/components/constance.dart';
import 'package:shopping_app/layout/appcubit/appCubit.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/state.dart';
import 'package:shopping_app/models/login_model.dart';

class ShopLayoutScreen extends StatelessWidget {
  const ShopLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = ShopLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Salla'
            ),

            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: (){
                    AppCubit.get(context).changeAppMode();
                  }, icon: Icon(Icons.dark_mode)),
            ],


          ),
          drawer: const NavigationDrawer(),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index){
              list.changeBottomNavBar(index);
            },
            currentIndex:  list.currentIndex,
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home)
              ),
              BottomNavigationBarItem(
                label: 'Categories',
                icon: Icon(Icons.apps)
              ),
              BottomNavigationBarItem(
                label: 'Favorites',
                icon: Icon(Icons.favorite_outlined)
              ),
              BottomNavigationBarItem(
                label: 'Carts',
                icon: Icon(Icons.shopping_cart_outlined)
              ),

              BottomNavigationBarItem(
                  label: 'Address',
                  icon: Icon(Icons.location_city_outlined)
              ),
              BottomNavigationBarItem(
                  label: 'Orders',
                  icon: Icon(Icons.location_city_outlined)
              ),

            ],
          ),
          body: list.screens[list.currentIndex],
        );
      },
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var user = ShopLayoutCubit.get(context).userModel!.data;
        return  ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).userModel != 0,
          builder: (context) => Drawer(
            child: SingleChildScrollView(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Material(
                color: Colors.blue.shade700,
                child: InkWell(
                  onTap: (){},
                  child: Container(
                    padding: EdgeInsets.only(top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 52,
                          backgroundImage: NetworkImage('${user!.image}')
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                            '${user.name}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white
                          ),
                        ),
                        Text(
                          '${user.email}',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white
                        ),

                        ),
                      ],
                    ),
                  ),
                ),
              ),
                  buildMenuItem(context)
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },

    );
  }

  Widget buildMenuItem(BuildContext context) => Container(
    padding: EdgeInsets.all(24),
    child: Wrap(
      runSpacing: 16,
      children: [
        ListTile(
          onTap: (){
            navigateTo(context, ProfileScreen());
          },
          leading: Icon(Icons.person),
          title: Text(
            'My Profile'
          ),
        ),
        Container(

          alignment: AlignmentDirectional.center,
          height: 30,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(6)
          ),
          child: Text(
            'Setting'
          ),
        ),
        ListTile(
          onTap: (){
            navigateTo(context, ChangePassword());
          },
          leading: Icon(Icons.key),
          title: Text(
              'Change Password'
          ),
        ),
        ListTile(
          onTap: (){
            AppCubit.get(context).changeAppMode();
          },
          leading: Icon(Icons.light_mode),
          title: Text(
              'Theme Mode'
          ),
        ),
        ListTile(
          onTap: (){

          },
          leading: Icon(Icons.language_outlined),
          title: Text(
              'en'
          ),
        ),
        Text(
          'FAQS',style: TextStyle(
          fontSize: 17,
          color: Colors.blueGrey
        ),
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ExpansionTile(
                backgroundColor: Colors.grey[50],
                  iconColor: Colors.blueGrey,
                  tilePadding: EdgeInsets.symmetric(horizontal: 10),
                  controlAffinity: ListTileControlAffinity.trailing,
                  trailing: ShopLayoutCubit.get(context).expansionIcon ? Icon(Icons.keyboard_arrow_up) : Icon(Icons.keyboard_arrow_down) ,
                  title: Row(
                    children: [
                      Icon(Icons.add_card_outlined, size: 24,),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          ShopLayoutCubit.get(context).faqsModel!.data!.data![index].question!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 14
                          ),
                        ),
                      )
                    ],

                  ),
                children: [
                  Text(
                    ShopLayoutCubit.get(context).faqsModel!.data!.data![index].answer!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey
                    ),
                  )
                ],
                onExpansionChanged: (value){
                  ShopLayoutCubit.get(context).changeExpansionIcon(value);
                },
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
            itemCount: ShopLayoutCubit.get(context).faqsModel!.data!.data!.length),
        Spacer(),
        ListTile(
          onTap: (){
            signOut(context);
          },
          leading: Icon(Icons.output_outlined),
          title: Text(
              'sign out'
          ),
        ),
      ],
    ),
  );
}


