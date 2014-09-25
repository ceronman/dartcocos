// Copyright 2014 Manuel Cerón <ceronman@gmail.com>
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

part of cocos;

abstract class Collidable {
  Aabb2 get hitbox;
}

class Side {
  static const int TOP = 1;
  static const int BOTTOM = 2;
  static const int LEFT = 4;
  static const int RIGHT = 8;
  static const int ALL = 15;
}

class CollisionEvent {
  Collidable body1;
  int side1;
  Collidable body2;
  int side2;

  CollisionEvent(this.body1, this.side1, this.body2, this.side2);
}

abstract class Collision {
  StreamController<CollisionEvent> onCollisionController =
      new StreamController<CollisionEvent>();
  Stream<CollisionEvent> get onCollision =>
      onCollisionController.stream.asBroadcastStream();

  void check();
}

class OuterBoxCollision extends Collision {
  Collidable outer;
  Collidable inner;

  OuterBoxCollision(this.inner, this.outer);

  void check() {
    if (inner.hitbox.min.x < outer.hitbox.min.x) {
      onCollisionController.add(
          new CollisionEvent(inner, Side.LEFT, outer, Side.LEFT));
    }
    if (inner.hitbox.max.x > outer.hitbox.max.x) {
      onCollisionController.add(
          new CollisionEvent(inner, Side.RIGHT, outer, Side.RIGHT));
    }
    if (inner.hitbox.min.y < outer.hitbox.min.y) {
      onCollisionController.add(
          new CollisionEvent(inner, Side.TOP, outer, Side.TOP));
    }
    if (inner.hitbox.max.y > outer.hitbox.max.y) {
      onCollisionController.add(
          new CollisionEvent(inner, Side.BOTTOM, outer, Side.BOTTOM));
    }
  }
}
