import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GameScreen();
}

class _GameScreen extends State<GameScreen> {

  bool get isPlaying => _controller?.isActive ?? false;

  Artboard? _rivArtboard;
  StateMachineController? _controller;
  SMIInput<bool>? _hit;
  SMIInput<bool>? _reset;
  SMIInput<bool>? _isHover;

  @override
  void initState() {
    super.initState();

    rootBundle.load('assets/thanksgiving_game.riv').then((data) async {
      final file = RiveFile.import(data);

      final artboard = file.mainArtboard;
      var controller =
          StateMachineController.fromArtboard(artboard, 'State Machine 1');
      if (controller != null) {
        artboard.addController(controller);
        _hit = controller.findInput('Hit');
        _reset = controller.findInput('Pressed');
        _isHover = controller.findInput('isHover');
      }
      setState(() => _rivArtboard = artboard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   title: const Text('Fly ME'),
        // ),
        body: Center(
          child: Column(
            children: [
              Center(
                child: _rivArtboard == null
                    ? const SizedBox()
                    : MouseRegion(
                        onEnter: (_) => _isHover?.value = true,
                        onExit: (_) => _isHover?.value = false,
                        child: GestureDetector(
                          onTapDown: (_) => _hit?.value = true,
                          onTapCancel: () => _hit?.value = false,
                          onTapUp: (_) => _hit?.value = false,
                          // onLongPress: () => _reset?.value = true,
                          child: SizedBox(
                            width: 465,
                            height: 460,
                            // width: MediaQuery.of(context).size.width,
                            // height: MediaQuery.of(context).size.height,
                            child: Rive(
                              alignment: Alignment.center,
                              artboard: _rivArtboard!,
                            ),
                          ),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: MaterialButton(
                  height: 40.0,
                  minWidth: 180.0,
                  elevation: 3.5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                  color: Color.fromARGB(100, 255, 255, 244),
                  textColor: Colors.white,
                  child: Text("RESET"),
                  onPressed: () => _reset?.value = true,
                  splashColor: Colors.redAccent,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
