import 'package:bonfire/bonfire.dart';
import 'package:bonfire_flutter_game/MainGame.dart';
import 'package:bonfire_flutter_game/SharedPreferences/Cash_Save.dart';
import 'package:bonfire_flutter_game/constant/NameOfMaps.dart';
import 'package:bonfire_flutter_game/constant/constant.dart';
import 'package:bonfire_flutter_game/player/Main_Player.dart';
import 'package:flame_audio/flame_audio.dart';



class PotionLife extends GameDecoration with Sensor<Kinght>
{
  PotionLife({required Vector2 position}): super.withAnimation(animation:SpriteAnimation.load('items/potion_life.png', SpriteAnimationData.sequenced(amount: 4, stepTime: 0.2, textureSize: Vector2(16, 16))) , position: position, size: Vector2.all(15.0));


  @override
  void onContact(GameComponent component) {

    SFX ==true ? FlameAudio.play('power_up.wav') : null ;

    gameRef.player!.addLife(lifePotion);
    removeFromParent();
  }

}

class add_stamina extends GameDecoration with Sensor<Kinght>
{
  add_stamina({required Vector2 position}): super.withAnimation(animation:SpriteAnimation.load('items/potion_stamina.png', SpriteAnimationData.sequenced(amount: 4, stepTime: 0.2, textureSize: Vector2(16, 16))) , position: position, size: Vector2.all(15.0));
  @override
  void onContact(GameComponent component) {

    SFX ==true ? FlameAudio.play('power_up.wav') : null ;
    (gameRef.player as Kinght).stamina += 30;
      if ((gameRef.player as Kinght).stamina > 100) {
        (gameRef.player as Kinght).stamina = 100;
    }


    removeFromParent();
  }

}

class Radio_House extends GameDecoration with Sensor<Kinght>
{
  Radio_House({required Vector2 position}): super.withAnimation(animation: SpriteAnimation.load(

    "Maps/House.png",
    SpriteAnimationData([
      SpriteAnimationFrameData(srcPosition: Vector2(0, 384), srcSize: Vector2(16, 16), stepTime: 0.1),
    ],loop: false),

  ), position: position, size: Vector2.all(20));


  @override
  void onContact(GameComponent component) {

    CashSaver.getData(key: 'SFX') ==true ? FlameAudio.play('power_up.wav') : null ;
    gameRef.player!.addLife(lifePotion);
    removeFromParent();
  }

}

class BedRoom_Door extends GameDecoration with Sensor<Kinght>
{
  BedRoom_Door({required Vector2 position}): super.withAnimation(animation: SpriteAnimation.load(

    "Maps/House.png",
    SpriteAnimationData([
      SpriteAnimationFrameData(srcPosition: Vector2(32, 352), srcSize: Vector2(16, 16), stepTime: 0.1),
    ],loop: false),

  ), position: position, size: Vector2(30,30));


  @override
  void onContact(GameComponent component) {
    removeFromParent();
  }

}

class Chest extends GameDecoration with Sensor<Kinght>
{
  Chest({required Vector2 position}): super.withAnimation(size:  Vector2.all(25.0) ,animation: SpriteAnimation.load(
    "items/chest_spritesheet.png",
    SpriteAnimationData.sequenced(
      amount: 8,
      stepTime: 0.2,
      textureSize: Vector2(16, 16),
    ),
  ) ,position: position );


  @override
  void onContact(GameComponent component) {

    removeFromParent();
   selectMap(1);
    //gameRef.pauseEngine();
   // gameRef.overlayManager.add(LevelWonScreen.id);
  }

}

class Chest_easter extends GameDecoration with Sensor<Kinght>
{
  Chest_easter({required Vector2 position}): super.withAnimation(animation: SpriteAnimation.load(

    "Maps/House.png",
    SpriteAnimationData([
      SpriteAnimationFrameData(srcPosition: Vector2(112, 384), srcSize: Vector2(16, 16), stepTime: 0.1),
    ],loop: false),

  ), position: position, size: Vector2(30,30));


  @override
  void onContact(GameComponent component) {
    SFX ==true ? FlameAudio.play('power_up.wav') : null ;
    removeFromParent();
  }

}

class Mirror_C_B extends GameDecoration with Sensor<Kinght>
{
  Mirror_C_B({required Vector2 position}): super.withAnimation(size:  Vector2.all(16) ,animation: SpriteAnimation.load(
    "Interface/Mirror_C.png",
    SpriteAnimationData.sequenced(
      amount: 4 ,
      loop:false,
      stepTime: 0.2,
      textureSize: Vector2(32, 32),
    ),
  ) ,position: position );


  @override
  void onContact(GameComponent component) {

 //TODO add Audio


  }

}

class Mirror_C extends GameDecoration with Sensor<Kinght> ,ObjectCollision
{
  Mirror_C({required Vector2 position}) : super.withSprite(
      size: Vector2.all(16),
      sprite: Sprite.load('Interface/Mirror_C.png', srcSize: Vector2(32, 32)),
      position: position);

  @override
  void onContact(GameComponent component) {
    removeFromParent();
    gameRef.add(Mirror_C_B(position: position));
    FlameAudio.play('Mirror_Crack.mp3',volume: 0.9);
    gameRef.add(
      AnimatedFollowerObject(
        animation: SpriteAnimation.load(
          unclear,
          SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.2,
            textureSize: Vector2(32, 32),
          ),
        ),
        target: gameRef.player,
        size: Vector2(16, 16),
        positionFromTarget: Vector2(18, -15),
      ),
    );
  }
}

bool islight = false ;
class Picktorch extends GameDecoration with Sensor<Kinght>
{
  Picktorch({required Vector2 position})
      : super.withAnimation(
    animation: SpriteAnimation.load(
      "Interface/torch_spritesheet.png",
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.2,
        textureSize: Vector2(16, 16),
      ),
    ),
    position: position,
    size: Vector2.all(16),
  ) {



  }
  @override
  void onContact(GameComponent component) {
    if (component is Kinght) {
      component.Taketorch = true ;
      CashSaver.SaveData(key: 'torch', value: true);
    }

    removeFromParent();
    // component = component as GreenNinjaPlayer;
    // FlameAudio.play(Globals.fireSound);
    // component.showDamage(_damage);
    // component.removeLife(_damage);
  }
}

class Key_silver extends GameDecoration with Sensor<Kinght>
{
  Key_silver({required Vector2 position , required String key})
      : super.withAnimation(
    animation: SpriteAnimation.load(
      key,
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.2,
        textureSize: Vector2(16, 16),
      ),
    ),
    position: position,
    size: Vector2.all(10),
  ) {}

  @override
  void onContact(GameComponent component) {
    if (component is Kinght) {
      component.silverKey = true ;
    }
    // FlameAudio.play(Globals.fireSound);
    removeFromParent();

  }
}