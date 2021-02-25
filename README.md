# Realistic Material Wetness
A unified function to create realistic wet materials in Unity.

![](/Images/RealisticMaterialWetness700x300.png)

Since physically based rendering (PBR) is now a standard in most games we try to simulate better and more lighting models that cover more material types. With the classic lighting model, everybody chose to darken the diffuse term and boost the specular term. With the method explained below you can provide a way to simulate wet surfaces while keeping your material physically accurate.

We can easily distinguish between a dry and wet surface. The best visual cue is that wet surfaces look darker, have a higher specular value, and exhibit subtle changes in saturation.
This behavior is made by rough/porous materials (brick, clay, concrete, plaster...), Absorbent materials (cotton, fabric), and organic materials like hair. Materials that are smooth don't change however since they are already reflecting a lot of light.

System requirements
-------------------

- Unity 2020.2
- Universal Render Pipeline 10.2.2
