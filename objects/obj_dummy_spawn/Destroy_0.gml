ds_queue_clear(global.dummy_targets_queue);
instance_create_layer(x,y,"Instances",obj_dummy_alternative);

global.dummy_pole_inst = instance_create_layer(x,y,"Shrines",obj_dummy_pole);
global.dummy_exists = true;



