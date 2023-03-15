{
  "spriteId": {
    "name": "spr_hp_fragment_alternative",
    "path": "sprites/spr_hp_fragment_alternative/spr_hp_fragment_alternative.yy",
  },
  "solid": false,
  "visible": true,
  "managed": true,
  "spriteMaskId": null,
  "persistent": false,
  "parentObjectId": {
    "name": "pobj_pickable",
    "path": "objects/pobj_pickable/pobj_pickable.yy",
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
    {"isDnD":false,"eventNum":0,"eventType":0,"collisionObjectId":null,"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
  ],
  "properties": [],
  "overriddenProperties": [
    {"propertyId":{"name":"pickup_script","path":"objects/pobj_pickable/pobj_pickable.yy",},"objectId":{"name":"pobj_pickable","path":"objects/pobj_pickable/pobj_pickable.yy",},"value":"HP_pick_up","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"pickup_parent","path":"objects/pobj_pickable/pobj_pickable.yy",},"objectId":{"name":"pobj_pickable","path":"objects/pobj_pickable/pobj_pickable.yy",},"value":"pobj_hero","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"animation_speed","path":"objects/pobj_pickable/pobj_pickable.yy",},"objectId":{"name":"pobj_pickable","path":"objects/pobj_pickable/pobj_pickable.yy",},"value":"0.015","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"life_time","path":"objects/pobj_pickable/pobj_pickable.yy",},"objectId":{"name":"pobj_pickable","path":"objects/pobj_pickable/pobj_pickable.yy",},"value":"FRAME_RATE * 15","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"fade_out_time","path":"objects/pobj_pickable/pobj_pickable.yy",},"objectId":{"name":"pobj_pickable","path":"objects/pobj_pickable/pobj_pickable.yy",},"value":"FRAME_RATE * 1.5","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
  ],
  "parent": {
    "name": "Buffs and Drops",
    "path": "folders/Objects/Else/Buffs and Drops.yy",
  },
  "resourceVersion": "1.0",
  "name": "obj_hp_fragment",
  "tags": [],
  "resourceType": "GMObject",
}