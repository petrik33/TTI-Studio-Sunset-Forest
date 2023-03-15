///@arg id
///@arg element
function ds_queue_find(_id, findElement){
	var queueCopy = ds_queue_create();
	ds_queue_copy(queueCopy,_id);
	var queueSize = ds_queue_size(queueCopy);
	var found = false;
	for(var i = 0; i < queueSize; i++)
	{
		var element = ds_queue_dequeue(queueCopy);
		if(element == findElement)
		{
			found = true;
			break;	
		}
	}
	ds_queue_destroy(queueCopy);
	return found;
}

///@arg id
///@arg element
function ds_queue_delete(_id, findElement){
	var queueCopy = ds_queue_create();
	ds_queue_copy(queueCopy,_id);
	var queueSize = ds_queue_size(queueCopy);
	var found = false;
	var newQueueCopy = ds_queue_create();
	for(var i = 0; i < queueSize; i++)
	{
		var element = ds_queue_dequeue(queueCopy);
		if(element != findElement)
		{
			ds_queue_enqueue(newQueueCopy,element);
		}
		else
		{
			found = true;	
		}
	}
	ds_queue_destroy(queueCopy);
	ds_queue_clear(_id);
	ds_queue_copy(_id,newQueueCopy);
	ds_queue_destroy(newQueueCopy);
	return found;
}