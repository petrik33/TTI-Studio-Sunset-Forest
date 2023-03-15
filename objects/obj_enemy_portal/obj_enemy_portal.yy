{
  "resourceType": "GMObject",
  "resourceVersion": "1.0",
  "name": "obj_enemy_portal",
  "spriteId": {
    "name": "spr_new_portal",
    "path": "sprites/spr_new_portal/spr_new_portal.yy",
  },
  "solid": false,
  "visible": true,
  "managed": true,
  "spriteMaskId": null,
  "persistent": false,
  "parentObjectId": {
    "name": "pobj_portal",
    "path": "objects/pobj_portal/pobj_portal.yy",
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
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":3,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":0,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":8,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":1,"collisionObjectId":null,},
  ],
  "properties": [
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"push_effect","varType":5,"value":"spr_portal_push","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":null,"multiselect":false,"filters":[
        "GMTileSet",
        "GMSprite",
        "GMSound",
        "GMPath",
        "GMScript",
        "GMShader",
        "GMFont",
        "GMTimeLine",
        "GMObject",
        "GMRoom",
      ],},
  ],
  "overriddenProperties": [
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"sprite_death","path":"objects/pobj_portal/pobj_portal.yy",},"objectId":{"name":"pobj_portal","path":"objects/pobj_portal/pobj_portal.yy",},"value":"spr_portal_destroyed",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"state_opened","path":"objects/pobj_portal/pobj_portal.yy",},"objectId":{"name":"pobj_portal","path":"objects/pobj_portal/pobj_portal.yy",},"value":"PortalStateOpened",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"portal_teleport_xoffset","path":"objects/pobj_portal/pobj_portal.yy",},"objectId":{"name":"pobj_portal","path":"objects/pobj_portal/pobj_portal.yy",},"value":"10",},
  ],
  "parent": {
    "name": "Statics",
    "path": "folders/Objects/Statics.yy",
  },
}