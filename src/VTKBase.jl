module VTKBase

include("VTKCellTypes/VTKCellTypes.jl")
using .VTKCellTypes
export VTKCellTypes, VTKCellType

"""
    VTKDataType

Union of integer, float and string data types allowed by VTK.
"""
const VTKDataType = Union{Int8, UInt8, Int16, UInt16, Int32, UInt32,
                          Int64, UInt64, Float32, Float64, String}

"""
    AbstractFieldData

Abstract type representing any kind of dataset.
"""
abstract type AbstractFieldData end

"""
    VTKPointData <: AbstractFieldData

Represents data that is to be attached to grid points.
"""
struct VTKPointData <: AbstractFieldData end

"""
    VTKCellData <: AbstractFieldData

Represents data that is to be attached to grid cells.
"""
struct VTKCellData <: AbstractFieldData end

"""
    VTKFieldData <: AbstractFieldData

Represents data that is not attached to the grid geometry.

This is typically used for lightweight metadata, such as timestep information or
strings.
"""
struct VTKFieldData <: AbstractFieldData end

export VTKPointData, VTKCellData, VTKFieldData

# These are the VTK names associated to each data "location".
node_type(::VTKPointData) = "PointData"
node_type(::VTKCellData) = "CellData"
node_type(::VTKFieldData) = "FieldData"

include("grid_types.jl")
include("mesh_cells.jl")
include("polydata.jl")

end
