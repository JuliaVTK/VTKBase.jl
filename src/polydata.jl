"""
    PolyData

Defines cell types for polygonal datasets.

The following singleton types are defined:

- `PolyData.Verts` for vertices,
- `PolyData.Lines` for lines,
- `PolyData.Strips` for triangular strips,
- `PolyData.Polys` for polygons.

"""
module PolyData

import ..VTKCellTypes: nodes

abstract type CellType end

struct Verts <: CellType end
struct Lines <: CellType end
struct Strips <: CellType end
struct Polys <: CellType end

# All of these cell types can take any number of grid points.
# (This is for compatibility with VTKCellTypes for unstructured datasets.)
nodes(::CellType) = -1

number_attr(::Type{Verts}) = "NumberOfVerts"
number_attr(::Type{Lines}) = "NumberOfLines"
number_attr(::Type{Strips}) = "NumberOfStrips"
number_attr(::Type{Polys}) = "NumberOfPolys"

xml_node(::Type{Verts}) = "Verts"
xml_node(::Type{Lines}) = "Lines"
xml_node(::Type{Strips}) = "Strips"
xml_node(::Type{Polys}) = "Polys"

end

import .PolyData

const PolyCell{T} = MeshCell{T} where {T <: PolyData.CellType}

Base.eltype(::Type{T}) where {T <: PolyCell} = cell_type(T)
cell_type(::Type{<:PolyCell{T}}) where {T} = T
grid_type(::Type{<:PolyCell}) = VTKPolyData()
