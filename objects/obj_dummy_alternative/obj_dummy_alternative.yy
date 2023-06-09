{
  "spriteId": {
    "name": "spr_dummy_body",
    "path": "sprites/spr_dummy_body/spr_dummy_body.yy",
  },
  "solid": false,
  "visible": true,
  "managed": true,
  "spriteMaskId": null,
  "persistent": false,
  "parentObjectId": {
    "name": "pobj_hitable",
    "path": "objects/pobj_hitable/pobj_hitable.yy",
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
  "eventList": [
    {"isDnD":false,"eventNum":0,"eventType":3,"collisionObjectId":null,"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
    {"isDnD":false,"eventNum":0,"eventType":1,"collisionObjectId":null,"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
    {"isDnD":false,"eventNum":0,"eventType":0,"collisionObjectId":null,"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
    {"isDnD":false,"eventNum":0,"eventType":2,"collisionObjectId":null,"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
    {"isDnD":false,"eventNum":1,"eventType":2,"collisionObjectId":null,"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
    {"isDnD":false,"eventNum":2,"eventType":2,"collisionObjectId":null,"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
  ],
  "properties": [
    {"varType":5,"value":"spr_dummy_portrait","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"portrait","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":3,"value":"True","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"drop_matter","tags":[],"resourceType":"GMObjectProperty",},
  ],
  "overriddenProperties": [
    {"propertyId":{"name":"max_hp","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"3","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"death_sound","path":"objects/pobj_moving_entity/pobj_moving_entity.yy",},"objectId":{"name":"pobj_moving_entity","path":"objects/pobj_moving_entity/pobj_moving_entity.yy",},"value":"sn_dummy_death","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"sprite_death","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"noone","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"hit_sound","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"sn_dummy_hit","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"state_free","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"DummyStateFree","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"flying","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"True","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"spd","path":"objects/pobj_moving_entity/pobj_moving_entity.yy",},"objectId":{"name":"pobj_moving_entity","path":"objects/pobj_moving_entity/pobj_moving_entity.yy",},"value":"1.25","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"acceleration_speed","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"1.5 / (FRAME_RATE * 0.01)","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"decceleration_speed","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"1.5 / (FRAME_RATE * 0.01)","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"_gravity","path":"objects/pobj_moving_entity/pobj_moving_entity.yy",},"objectId":{"name":"pobj_moving_entity","path":"objects/pobj_moving_entity/pobj_moving_entity.yy",},"value":"0.4","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
  ],
  "parent": {
    "name": "Else",
    "path": "folders/Objects/Entities/Else.yy",
  },
  "resourceVersion": "1.0",
  "name": "obj_dummy_alternative",
  "tags": [],
  "resourceType": "GMObject",
}