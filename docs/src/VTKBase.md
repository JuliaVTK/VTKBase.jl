# VTKBase.jl

The [VTKBase.jl](https://github.com/JuliaVTK/VTKBase.jl) package contains
common definitions used in the
[WriteVTK.jl](https://github.com/JuliaVTK/WriteVTK.jl) and
[ReadVTK.jl](https://github.com/JuliaVTK/ReadVTK.jl) packages.

## VTK dataset types

```@docs
AbstractVTKDataset
StructuredVTKDataset
VTKImageData
VTKRectilinearGrid
VTKStructuredGrid
UnstructuredVTKDataset
VTKPolyData
VTKUnstructuredGrid
```

## Field data types

In VTK, data can either be attached to the geometry (point and cell data), or
not (field data).

```@docs
VTKBase.AbstractFieldData
VTKPointData
VTKCellData
VTKFieldData
```

## Cells in unstructured grids

### General unstructured datasets

These are useful when working with general unstructured datasets (`.vtu` files).

```@docs
VTKCellTypes
VTKCellTypes.nodes
VTKBase.AbstractMeshCell
MeshCell
```

### Polygonal datasets

These are useful when working with polygonal datasets (`.vtp` files).

```@docs
PolyData
VTKPolyhedron
```

## Constants

```@docs
VTKBase.VTKDataType
```
