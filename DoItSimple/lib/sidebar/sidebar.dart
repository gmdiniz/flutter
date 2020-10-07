import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mytodolist/navigator/navigation_bloc.dart';

import 'package:mytodolist/sidebar/menu_item.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: -43,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data ? 0 : screenWidth - 35,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: const Color(0xFFF3FFE1),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      ListTile(
                        title: Text(
                          "Samuel",
                          style: TextStyle(color: Color(0xFF36213A), fontSize: 30, fontWeight: FontWeight.w800),
                        ),
                        subtitle: Text(
                          "PDI05",
                          style: TextStyle(
                            color: Color(0xFF36213E),
                            fontSize: 18,
                          ),
                        ),
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.person,
                            color: Color(0xFFF3FFE1),
                          ),
                          radius: 40,
                        ),
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Color(0xFF36213E),
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItem(
                        icon: Icons.home,
                        title: "To-Do",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickedEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.archive,
                        title: "Arquivados",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.ArchivedPageClickedEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.restore_from_trash,
                        title: "Lixeira",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.TrashPageClickedEvent);
                        },
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    child: Container(
                      padding: new EdgeInsets.all(10),
                      width: 35,
                      height: 110,
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_arrow,
                        color: Color(0xFFF3FFE1),
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
