#import('../lib/cocos.dart');

void main() {
  Director director = new Director('#gamebox');

  var layer = new Layer();
  var label = new Label('MoveTo 200, 200');

  label.position.x = director.canvas.width/2;
  label.position.y = director.canvas.height/2;

  layer.add(label);
  label.runAction(new MoveTo(new vec2(200, 200), 5));

  director.run(new Scene(layer));
}