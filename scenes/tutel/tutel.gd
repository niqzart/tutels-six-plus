extends Node3D

var original_main_material: StandardMaterial3D = self.get_node("Head").mesh.surface_get_material(0)
var original_detail_material: StandardMaterial3D = self.get_node("Shell").mesh.surface_get_material(0)

var main_material: StandardMaterial3D = original_main_material.duplicate()
var detail_material: StandardMaterial3D = original_detail_material.duplicate()


func _ready() -> void:
    var mesh_nodes: Array[MeshInstance3D] = []

    for child_node in self.get_children():
        if not is_instance_of(child_node, MeshInstance3D):
            continue
        mesh_nodes.append(child_node)

    for mesh_node in mesh_nodes:
        var mesh: ArrayMesh = mesh_node.mesh.duplicate()
        for surface_index in range(mesh.get_surface_count()):
            if mesh.surface_get_material(surface_index) == original_main_material:
                mesh.surface_set_material(surface_index, main_material)
            if mesh.surface_get_material(surface_index) == original_detail_material:
                mesh.surface_set_material(surface_index, detail_material)
        mesh_node.mesh = mesh


func set_main_color(color: Color) -> void:
    self.main_material.albedo_color = color
