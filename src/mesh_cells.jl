export
    MeshCell,
    Connectivity

"""
    AbstractMeshCell

Abstract type specifying a VTK cell.
"""
abstract type AbstractMeshCell end

Base.eltype(::Type{<:AbstractMeshCell}) = VTKCellTypes.VTKCellType

# By default, cells are attached to unstructured grids.
grid_type(::Type{<:AbstractMeshCell}) = VTKUnstructuredGrid()

const Connectivity{T} =
    Union{AbstractVector{T}, NTuple{N,T} where N} where {T <: Integer}

"""
    MeshCell <: AbstractMeshCell

Single cell element in unstructured or polygonal grid.

It is characterised by a cell type (for instance, `VTKCellType.TRIANGLE` or
`PolyData.Strips`) and by a connectivity vector determining the points on the
grid defining this cell.

---

    MeshCell(cell_type, connectivity)

Define a single cell element of an unstructured grid.

The `cell_type` argument characterises the type of cell (e.g. vertex, triangle,
hexaedron, ...):

- cell types for unstructured datasets are defined in the [`VTKCellTypes`](@ref)
module;
- cell types for polygonal datasets are defined in the [`PolyData`](@ref) module.

The `connectivity` argument is a vector or tuple containing the indices of the
points passed to [`vtk_grid`](@ref) which define this cell.

# Example

Define a triangular cell passing by points with indices `[3, 5, 42]`.

```jldoctest
julia> cell = MeshCell(VTKCellTypes.VTK_TRIANGLE, (3, 5, 42))
MeshCell{VTKCellType, Tuple{Int64, Int64, Int64}}(VTKCellType("VTK_TRIANGLE", 0x05, 3), (3, 5, 42))
```
"""
struct MeshCell{CellType, V <: Connectivity} <: AbstractMeshCell
    ctype::CellType  # cell type identifier (see VTKCellTypes.jl)
    connectivity::V  # indices of points (one-based, following the convention in Julia)
    function MeshCell(ctype, conn)
        if nodes(ctype) ∉ (length(conn), -1)
            error("Wrong number of nodes in connectivity vector.")
        end
        C = typeof(ctype)
        V = typeof(conn)
        new{C,V}(ctype, conn)
    end
end

cell_type(cell::MeshCell) = cell.ctype

# Obtain common integer type for holding connectivity indices.
# If all elements of `cells` have the same type, then the return type is equal
# to the element type of the `connectivity` field of each cell.
# Otherwise, fall back to Int.
function connectivity_type(cells)
    Cell = eltype(cells) :: Type{<:AbstractMeshCell}
    if isconcretetype(Cell)
        _connectivity_type(Cell) :: Type{<:Integer}
    else
        Int
    end
end

_connectivity_type(::Type{MeshCell{T,V}}) where {T,V} = _connectivity_type(V)
_connectivity_type(::Type{V}) where {V <: Connectivity} = eltype(V)
