{
  "resourceType": "GMObject",
  "resourceVersion": "1.0",
  "name": "obj_shrine",
  "spriteId": {
    "name": "spr_shrine",
    "path": "sprites/spr_shrine/spr_shrine.yy",
  },
  "solid": false,
  "visible": true,
  "managed": true,
  "spriteMaskId": {
    "name": "spr_shrine",
    "path": "sprites/spr_shrine/spr_shrine.yy",
  },
  "persistent": false,
  "parentObjectId": {
    "name": "pobj_tower",
    "path": "objects/pobj_tower/pobj_tower.yy",
  },
  "physicsObject": false,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsGroup": 0,
  "physicsDensity": 0.5,
  "physicsRestitution": 0.1,
  "physicsLinearDamping": 0.1,
  "physicsAngularDamping": 0.1,
  "physicsFriction": 0.2,
  "physicsStartAwake": true,
  "physicsKinematic": false,
  "physicsShapePoints": [],
  "eventList": [
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":1,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":0,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":3,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":8,"collisionObjectId":null,},
  ],
  "properties": [
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"animation_speed","varType":0,"value":"0.01","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],},
  ],
  "overriddenProperties": [
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"sprite_death","path":"objects/pobj_tower/pobj_tower.yy",},"objectId":{"name":"pobj_tower","path":"objects/pobj_tower/pobj_tower.yy",},"value":"spr_shrine_destruction",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"max_hp","path":"objects/pobj_tower/pobj_tower.yy",},"objectId":{"name":"pobj_tower","path":"objects/pobj_tower/pobj_tower.yy",},"value":"4",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"sprite_damaged","path":"objects/pobj_tower/pobj_tower.yy",},"objectId":{"name":"pobj_tower","path":"objects/pobj_tower/pobj_tower.yy",},"value":"spr_shrine_damaged",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"sprite_idle","path":"objects/pobj_tower/pobj_tower.yy",},"objectId":{"name":"pobj_tower","path":"objects/pobj_tower/pobj_tower.yy",},"value":"spr_shrine",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"hp_center_y_offset","path":"objects/pobj_tower/pobj_tower.yy",},"objectId":{"name":"pobj_tower","path":"objects/pobj_tower/pobj_tower.yy",},"value":"133",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"hp_distance_to_tower","path":"objects/pobj_tower/pobj_tower.yy",},"objectId":{"name":"pobj_tower","path":"objects/pobj_tower/pobj_tower.yy",},"value":"100",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"light_sprite","path":"objects/pobj_tower/pobj_tower.yy",},"objectId":{"name":"pobj_tower","path":"objects/pobj_tower/pobj_tower.yy",},"value":"spr_shrine_light",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"faded_death","path":"objects/pobj_tower/pobj_tower.yy",},"objectId":{"name":"pobj_tower","path":"objects/pobj_tower/pobj_tower.yy",},"value":"True",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"candles_fires_x","path":"objects/pobj_tower/pobj_tower.yy",},"objectId":{"name":"pobj_tower","path":"objects/pobj_tower/pobj_tower.yy",},"value":"[29,69,181,220]",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"candles_fires_y","path":"objects/pobj_tower/pobj_tower.yy",},"objectId":{"name":"pobj_tower","path":"objects/pobj_tower/pobj_tower.yy",},"value":"[42,0,0,42]",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"candle_fire_distance","path":"objects/pobj_tower/pobj_tower.yy",},"objectId":{"name":"pobj_tower","path":"objects/pobj_tower/pobj_tower.yy",},"value":"4",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"candles_number","path":"objects/pobj_tower/pobj_tower.yy",},"objectId":{"name":"pobj_tower","path":"objects/pobj_tower/pobj_tower.yy",},"value":"4",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"candle_sprite","path":"objects/pobj_tower/pobj_tower.yy",},"objectId":{"name":"pobj_tower","path":"objects/pobj_tower/pobj_tower.yy",},"value":"spr_shrine_candle_fire",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"step_sound_resource","path":"objects/pobj_tower/pobj_tower.yy",},"objectId":{"name":"pobj_tower","path":"objects/pobj_tower/pobj_tower.yy",},"value":"sn_crystal_step",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"death_sound","path":"objects/pobj_tower/pobj_tower.yy",},"objectId":{"name":"pobj_tower","path":"objects/pobj_tower/pobj_tower.yy",},"value":"noone",},
  ],
  "parent": {
    "name": "Statics",
    "path": "folders/Objects/Statics.yy",
  },
}