{
  "spriteId": {
    "name": "spr_boss_water_projectile",
    "path": "sprites/spr_boss_water_projectile/spr_boss_water_projectile.yy",
  },
  "solid": false,
  "visible": true,
  "managed": true,
  "spriteMaskId": null,
  "persistent": false,
  "parentObjectId": {
    "name": "pobj_untargeted_bullet",
    "path": "objects/pobj_untargeted_bullet/pobj_untargeted_bullet.yy",
  },
  "physicsObject": false,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsGroup": 1,
  "physicsDensity": 0.5,
  "physicsRestitution": 0.1,
  "physicsLinearDamping": 0.1,
  "physicsAngularDamping": 0.1,
  "physicsFriction": 0.2,
  "physicsStartAwake": true,
  "physicsKinematic": false,
  "physicsShapePoints": [],
  "eventList": [],
  "properties": [],
  "overriddenProperties": [
    {"propertyId":{"name":"hit_effect","path":"objects/pobj_moving_entity/pobj_moving_entity.yy",},"objectId":{"name":"pobj_moving_entity","path":"objects/pobj_moving_entity/pobj_moving_entity.yy",},"value":"spr_boss_water_projectile_hit","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"pobj_bullet","path":"objects/pobj_bullet/pobj_bullet.yy",},"objectId":{"name":"pobj_bullet","path":"objects/pobj_bullet/pobj_bullet.yy",},"value":"EntityMakeWet","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"spd","path":"objects/pobj_moving_entity/pobj_moving_entity.yy",},"objectId":{"name":"pobj_moving_entity","path":"objects/pobj_moving_entity/pobj_moving_entity.yy",},"value":"9.5","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"pobj_bullet","path":"objects/pobj_bullet/pobj_bullet.yy",},"objectId":{"name":"pobj_bullet","path":"objects/pobj_bullet/pobj_bullet.yy",},"value":"pobj_hero","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"pobj_bullet","path":"objects/pobj_bullet/pobj_bullet.yy",},"objectId":{"name":"pobj_bullet","path":"objects/pobj_bullet/pobj_bullet.yy",},"value":"True","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"_gravity","path":"objects/pobj_moving_entity/pobj_moving_entity.yy",},"objectId":{"name":"pobj_moving_entity","path":"objects/pobj_moving_entity/pobj_moving_entity.yy",},"value":"0.01","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"enemy_parent","path":"objects/pobj_projectile/pobj_projectile.yy",},"objectId":{"name":"pobj_projectile","path":"objects/pobj_projectile/pobj_projectile.yy",},"value":"pobj_hero","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"on_hit_script","path":"objects/pobj_projectile/pobj_projectile.yy",},"objectId":{"name":"pobj_projectile","path":"objects/pobj_projectile/pobj_projectile.yy",},"value":"EntityMakeWet","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
  ],
  "parent": {
    "name": "Bullets",
    "path": "folders/Objects/Effects/Bullets.yy",
  },
  "resourceVersion": "1.0",
  "name": "obj_boss_water_projectile",
  "tags": [],
  "resourceType": "GMObject",
}