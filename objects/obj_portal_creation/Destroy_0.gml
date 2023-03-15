///@desc Create Portals
var _inst = PortalCreate(-image_xscale);
with(_inst)
{
	portal_spawning = false;	
}
if(image_xscale == -1)
{
	global.rightPortal = _inst;
}
else
{
	global.leftPortal = _inst;
	ConnectPortals();
}
