{
  "spriteId": {
    "name": "spr_dummy_idle",
    "path": "sprites/spr_dummy_idle/spr_dummy_idle.yy",
  },
  "solid": false,
  "visible": true,
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
    {"isDnD":false,"eventNum":0,"eventType":3,"collisionObjectId":null,"parent":{"name":"obj_dummy","path":"objects/obj_dummy/obj_dummy.yy",},"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
    {"isDnD":false,"eventNum":0,"eventType":1,"collisionObjectId":null,"parent":{"name":"obj_dummy","path":"objects/obj_dummy/obj_dummy.yy",},"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
  ],
  "properties": [
    {"varType":5,"value":"spr_dummy_portrait","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"portrait","tags":[],"resourceType":"GMObjectProperty",},
  ],
  "overriddenProperties": [
    {"propertyId":{"name":"_gravity","path":"objects/pobj_moving_entity/pobj_moving_entity.yy",},"objectId":{"name":"pobj_moving_entity","path":"objects/pobj_moving_entity/pobj_moving_entity.yy",},"value":"0.3","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"max_hp","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"3","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"state_free","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"DummyStateFree","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"death_sound","path":"objects/pobj_moving_entity/pobj_moving_entity.yy",},"objectId":{"name":"pobj_moving_entity","path":"objects/pobj_moving_entity/pobj_moving_entity.yy",},"value":"noone","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"sprite_death","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"noone","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
  ],
  "parent": {
    "name": "Entities",
    "path": "folders/Objects/Entities.yy",
  },
  "resourceVersion": "1.0",
  "name": "obj_dummy",
  "tags": [],
  "resourceType": "GMObject",
}