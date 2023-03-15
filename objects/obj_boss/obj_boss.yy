{
  "resourceType": "GMObject",
  "resourceVersion": "1.0",
  "name": "obj_boss",
  "spriteId": {
    "name": "spr_boss_idle",
    "path": "sprites/spr_boss_idle/spr_boss_idle.yy",
  },
  "solid": false,
  "visible": true,
  "managed": true,
  "spriteMaskId": null,
  "persistent": false,
  "parentObjectId": {
    "name": "pobj_boss",
    "path": "objects/pobj_boss/pobj_boss.yy",
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
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":0,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":1,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":3,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":8,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":2,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":1,"eventType":2,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":2,"eventType":2,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":3,"eventType":2,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":4,"eventType":2,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":5,"eventType":2,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":6,"eventType":2,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":7,"eventType":2,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":8,"eventType":2,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":9,"eventType":2,"collisionObjectId":null,},
  ],
  "properties": [],
  "overriddenProperties": [
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"sprite_death","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"spr_boss_death_idle_final",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"pushing_speed","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"7",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"pushing_direction","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"45",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"spd","path":"objects/pobj_moving_entity/pobj_moving_entity.yy",},"objectId":{"name":"pobj_moving_entity","path":"objects/pobj_moving_entity/pobj_moving_entity.yy",},"value":"0.2",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"_gravity","path":"objects/pobj_moving_entity/pobj_moving_entity.yy",},"objectId":{"name":"pobj_moving_entity","path":"objects/pobj_moving_entity/pobj_moving_entity.yy",},"value":"1",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"max_hp","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"3",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"acceleration_speed","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"0.2/ boss_acceleration_time",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"decceleration_speed","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"0.2/ boss_decceleration_time",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":null,"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"spr_boss_dash_attack",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"flying","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"True",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"flying_y","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"FLOOR_Y - boss_dist_to_floor",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"state_free","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"BossStateFree",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"sprite_run","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"spr_boss_tornado",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"sprite_idle","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"spr_boss_idle",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"sprite_pushed","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"objectId":{"name":"pobj_alive_entity","path":"objects/pobj_alive_entity/pobj_alive_entity.yy",},"value":"spr_boss_idle",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"push_vulnerable","path":"objects/pobj_moving_entity/pobj_moving_entity.yy",},"objectId":{"name":"pobj_moving_entity","path":"objects/pobj_moving_entity/pobj_moving_entity.yy",},"value":"True",},
  ],
  "parent": {
    "name": "Entities",
    "path": "folders/Objects/Entities.yy",
  },
}