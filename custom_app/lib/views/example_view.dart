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
  var _isButtonBusy = false;
  var _isButtonActive = false;
  var _isIconButtonActive = false;

  @override
  void initState() {
    _isButtonBusy = false;
    _isButtonActive = false;
    _isIconButtonActive = false;
    super.initState();
  }

  void _onButtonPressed() {
    log('CustomUI Button pressed');
  }

  void _onIconButtonPressed() {
    log('CustomUI IconButton pressed');
  }

  void _onButtonTap() {
    setState(() {
      _isButtonBusy = true;
      Future.delayed(
        const Duration(
          seconds: 2,
        ),
        () => setState(() {
          _isButtonBusy = false;
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
            const SizedBox(
              height: 16.0,
            ),
            CustomText.headingOne('Buttons'),
            const Divider(),
            // CustomText.subheading('custom text'),
            // CustomText.body('This is a sample body text.'),
            const SizedBox(
              height: 16.0,
            ),
            CustomText.caption('iOS'),
            CupertinoButton(
              onPressed: () => log('Plain iOS button pressed'),
              padding: const EdgeInsets.all(13.0), // Height 48
              child: const Text('Plain iOS button'),
            ),
            const SizedBox(
              height: 8.0,
            ),
            CupertinoButton.filled(
              onPressed: () => log('Filled iOS pressed'),
              padding: const EdgeInsets.all(13.0), // Height 48
              child: const Text('Filled iOS button'),
            ),
            const SizedBox(
              height: 8.0,
            ),
            // TODO: Add Grey button
            // TODO: Add Tinted button
            // * https://developer.apple.com/design/human-interface-guidelines/components/menus-and-actions/buttons#:~:text=what%20it%20does.-,Style,-System%20buttons%20offer
            // ? Outlined iOS button
            // DecoratedBox(
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Theme.of(context).primaryColor),
            //     borderRadius: const BorderRadius.all(
            //         Radius.circular(8.0 * 1.18)), // + 18%
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(1.0),
            //     child: CupertinoButton(
            //       onPressed: () => log('iOS button pressed'),
            //       padding: const EdgeInsets.all(13.0), // Height 48
            //       child: const Text('iOS button'),
            //     ),
            //   ),
            // ),
            CustomText.caption('Android'),
            TextButton(
              onPressed: () => log('Text Android button pressed'),
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.all(15.0),
                ), // Height 48
              ),
              //padding: const EdgeInsets.all(12.0),
              child: const Text('Text Android button'),
            ),
            const SizedBox(
              height: 8.0,
            ),
            OutlinedButton(
              onPressed: () => log('Outlined Android button pressed'),
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.all(15.0),
                ), // Height 48
              ),
              //padding: const EdgeInsets.all(12.0),
              child: const Text('Outlined Android button'),
            ),
            const SizedBox(
              height: 8.0,
            ),
            ElevatedButton(
              onPressed: () => log('Elevated Android button pressed'),
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.all(15.0),
                ), // Height 48
              ),
              //padding: const EdgeInsets.all(12.0),
              child: const Text('Elevated Android button'),
            ),
            const SizedBox(
              height: 8.0,
            ),
            CustomText.caption('Based on platform'),
            PlatformWidget(
              cupertino: (_, __) => CupertinoButton.filled(
                onPressed: () => log('Filled iOS pressed'),
                padding: const EdgeInsets.all(13.0), // Height 48
                child: const Text('Filled iOS button'),
              ),
              material: (_, __) => ElevatedButton(
                onPressed: () => log('Elevated Android button pressed'),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(15.0),
                  ), // Height 48
                ),
                //padding: const EdgeInsets.all(12.0),
                child: const Text('Elevated Android button'),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            CustomText.caption('Custom UI based on platform'),
            CustomButton.plain(
              onPressed: _onButtonPressed,
              text: 'Plain button',
            ),
            const SizedBox(
              height: 8.0,
            ),
            CustomButton.filled(
              onPressed: _onButtonPressed,
              text: 'Primary button',
            ),
            const SizedBox(
              height: 8.0,
            ),
            CustomButton.toggle(
              onPressed: _onButtonPressed,
              toggleType1: CustomButtonType.filled,
              text: 'Primary toggle button',
            ),
            // const SizedBox(
            //   height: 8.0,
            // ),
            // CustomButton(
            //   title: 'Future button',
            //   busy: isButtonBusy,
            //   onTap: _onButtonTap,
            // ),
            // const SizedBox(
            //   height: 8.0,
            // ),
            // const CustomButton(
            //   title: 'Disabled button',
            // ),
            // const SizedBox(
            //   height: 8.0,
            // ),
            // CustomButton.outline(
            //   title: 'Outline button',
            //   onTap: () => log('Tapped'),
            // ),
            const SizedBox(
              height: 32.0,
            ),
            CustomText.headingOne('Icon buttons'),
            const Divider(),
            CustomText.caption('iOS'),
            Center(
              child: Container(
                color: const Color(0xFF1A2842),
                child: CupertinoButton(
                  onPressed: () => log('info pressed'),
                  padding: const EdgeInsets.all(12.0),
                  child: const Icon(
                    CupertinoIcons.info_circle,
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
            CustomText.caption('Android'),
            Center(
              child: PlatformWidget(
                cupertino: (_, __) => Container(
                  color: const Color(0xFF1A2842),
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      color: Colors.orange,
                      onPressed: () => log('info pressed'),
                      icon: const Icon(Icons.info_outline),
                    ),
                  ),
                ),
                material: (_, __) => Container(
                  color: const Color(0xFF1A2842),
                  child: IconButton(
                    color: Colors.orange,
                    onPressed: () => log('info pressed'),
                    icon: const Icon(Icons.info_outline),
                  ),
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
            CustomIconButton.plain(
              onPressed: _onIconButtonPressed,
              materialIcon: Icons.info_outline,
              materialActiveIcon: Icons.info,
              cupertinoIcon: CupertinoIcons.info_circle,
              cupertinoActiveIcon: CupertinoIcons.info_circle_fill,
            ),
            const SizedBox(
              height: 8.0,
            ),
            CustomIconButton.filled(
              onPressed: _onIconButtonPressed,
              materialIcon: Icons.info_outline,
              materialActiveIcon: Icons.info,
              cupertinoIcon: CupertinoIcons.info_circle,
              cupertinoActiveIcon: CupertinoIcons.info_circle_fill,
            ),
            const SizedBox(
              height: 8.0,
            ),
            CustomIconButton.toggle(
              onPressed: _onIconButtonPressed,
              materialIcon: Icons.info_outline,
              materialActiveIcon: Icons.info,
              cupertinoIcon: CupertinoIcons.info_circle,
              cupertinoActiveIcon: CupertinoIcons.info_circle_fill,
              isFilled: true,
            ),
            const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
