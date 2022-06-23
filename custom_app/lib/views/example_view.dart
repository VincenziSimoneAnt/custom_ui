import 'dart:developer' show log;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_ui/custom_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ExampleView extends StatefulWidget {
  const ExampleView({Key? key}) : super(key: key);

  @override
  State<ExampleView> createState() => _ExampleViewState();
}

class _ExampleViewState extends State<ExampleView> {
  var isButtonBusy = false;

  @override
  void initState() {
    isButtonBusy = false;
    super.initState();
  }

  void _onButtonTap() {
    setState(() {
      isButtonBusy = true;
      Future.delayed(
        const Duration(
          seconds: 2,
        ),
        () => setState(() {
          isButtonBusy = false;
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(),
      // appBar: const PreferredSize(
      //   preferredSize: Size.fromHeight(120),
      //   child: PlatformAppBar(
      //     Text('TITLE'),
      //   ),
      // ),
      body: SafeArea(
        child: ListView(
          // ListView instead of Column to enable scrolling
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          children: [
            CustomText.headingOne('Design system'),
            const Divider(),
            CustomText.subheading('custom text'),
            CustomText.body('This is a sample body text.'),
            const SizedBox(
              height: 16.0,
            ),
            CustomButton(
              title: 'Primary button',
              onTap: () => log('Tapped'),
            ),
            const SizedBox(
              height: 8.0,
            ),
            CustomButton(
              title: 'Future button',
              busy: isButtonBusy,
              onTap: _onButtonTap,
            ),
            const SizedBox(
              height: 8.0,
            ),
            const CustomButton(
              title: 'Disabled button',
            ),
            const SizedBox(
              height: 8.0,
            ),
            CustomButton.outline(
              title: 'Outline button',
              onTap: () => log('Tapped'),
            ),
            const SizedBox(
              height: 16.0,
            ),
            CustomText.caption('iOS'),
            Center(
              child: Container(
                color: const Color(0xFF1A2842),
                child: CupertinoButton(
                  onPressed: () => log('info pressed'),
                  child: const Icon(
                    CupertinoIcons.info_circle,
                    color: Colors.orange,
                    //size: 100,
                  ),
                ),
              ),
            ),
            CustomText.caption('Android'),
            Container(
              color: const Color(0xFF1A2842),
              child: Material(
                child: IconButton(
                  color: Colors.orange,
                  onPressed: () => log('info pressed'),
                  icon: const Icon(Icons.info_outline),
                ),
              ),
            ),
            CustomText.caption('Based on platform'),
            PlatformIconButton(
              onPressed: () => log('info pressed'),
              materialIcon: const Icon(Icons.info_outline),
              cupertinoIcon: const Icon(CupertinoIcons.info),
              material: (_, __) => MaterialIconButtonData(),
              cupertino: (_, __) => CupertinoIconButtonData(),
            ),
            CustomText.caption('Custom UI based on platform'),
            const CustomIconButton(
              materialIcon: Icons.info_outline,
              materialActiveIcon: Icons.info,
              cupertinoIcon: CupertinoIcons.info_circle,
              cupertinoActiveIcon: CupertinoIcons.info_circle_fill,
            ),
          ],
        ),
      ),
    );
  }
}
