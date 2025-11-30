                                                                               
//= INCLUDES =========
#include "common.hlsl"
//====================
                                                                            
gbuffer_vertex main_vs(Vertex_PosUvNorTan input, uint instance_id : SV_InstanceID)
{
    float3 f3_value_2 = pass_get_f3_value2();
    uint index_light = (uint) f3_value_2.x; // index of the light into the bindless array
    uint index_array = (uint) f3_value_2.y; // index of a particular slice of the texture array of the light
    
    Light light;
    Surface surface;
    light.Build(index_light, surface);

    gbuffer_vertex vertex = transform_to_world_space(input, instance_id, buffer_pass.transform);
    vertex.position_clip = mul(float4(vertex.position, 1.0f), light.transform[index_array]);

    return vertex;
}
