import 'package:flutter/material.dart';
import 'package:focus_view/focus_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus View Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Focus View Demo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FocusView(
        mainSpacing: 14,
        crossSpacing: 14,
        padding: const EdgeInsets.all(14),
        // topSide: _buildTopView(),
        leftSide: _buildLeftView(),
        // rightSide: _buildRightView(),
        // bottomSide: _buildBottomView(),
        builder: (_, node, __) {
          return _buildFocusStyle(
              node,
              GridView.builder(
                itemCount: 100,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                itemBuilder: (_, index) {
                  return _buildFocusItem('body $index');
                },
              ));
        },
      ),
    );
  }

  // 构建顶部视图
  FocusViewSide _buildTopView() {
    return FocusViewSide(
      builder: (_, node, __) {
        return _buildFocusStyle(
            node,
            GridView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
              ),
              itemBuilder: (_, index) {
                return _buildFocusItem('top $index');
              },
            ));
      },
      constraints: const BoxConstraints(maxHeight: 100),
    );
  }

  // 构建左侧视图
  FocusViewSide _buildLeftView() {
    return FocusViewSide(
      builder: (_, node, __) {
        return _buildFocusStyle(
            node,
            GridView.builder(
              itemCount: 100,
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (_, index) {
                return _buildFocusItem('left $index');
              },
            ));
      },
      constraints: const BoxConstraints(maxWidth: 220),
    );
  }

  // 构建右侧视图
  FocusViewSide _buildRightView() {
    return FocusViewSide(
      builder: (_, node, __) {
        return _buildFocusStyle(
            node,
            GridView.builder(
              itemCount: 100,
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (_, index) {
                return _buildFocusItem('right $index');
              },
            ));
      },
      constraints: const BoxConstraints(maxWidth: 220),
    );
  }

  // 构建底部视图
  FocusViewSide _buildBottomView() {
    return FocusViewSide(
      builder: (_, node, __) {
        return _buildFocusStyle(
            node,
            GridView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
              ),
              itemBuilder: (_, index) {
                return _buildFocusItem('bottom $index');
              },
            ));
      },
      constraints: const BoxConstraints(maxHeight: 100),
    );
  }

  // 构建焦点选中样式
  Widget _buildFocusStyle(FocusNode node, Widget? child) {
    return Container(
      decoration: node.hasFocus
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            )
          : null,
      child: child,
    );
  }

  // 构建焦点子项
  Widget _buildFocusItem(String text) {
    return FocusTile(
      builder: (_, node, __) {
        return _buildFocusStyle(
            node,
            Column(children: [
              Image.asset(
                'assets/tv_item.jpg',
                width: 80,
                height: 80,
              ),
              Text(text),
            ]));
      },
      onConfirm: () {
        print('点击enter在当前焦点元素上触发确认事件');
      },
      onMenu: () {
        print('点击tab在当前焦点元素上触发菜单事件');
      },
    );
  }
}
