xof 0303txt 0032

template XSkinMeshHeader {
 <3cf169ce-ff7c-44ab-93c0-f78f62d172e2>
 WORD nMaxSkinWeightsPerVertex;
 WORD nMaxSkinWeightsPerFace;
 WORD nBones;
}

template VertexDuplicationIndices {
 <b8d65549-d7c9-4995-89cf-53a9a8b031e3>
 DWORD nIndices;
 DWORD nOriginalVertices;
 array DWORD indices[nIndices];
}

template SkinWeights {
 <6f0d123b-bad2-4167-a0d0-80224f25fabb>
 STRING transformNodeName;
 DWORD nWeights;
 array DWORD vertexIndices[nWeights];
 array FLOAT weights[nWeights];
 Matrix4x4 matrixOffset;
}


Mesh Mesh_skybox {
 24;
 2.000000;2.000000;-2.000000;,
 -2.000000;2.000000;-2.000000;,
 2.000000;2.000000;2.000000;,
 2.000000;2.000000;-2.000000;,
 -2.000000;2.000000;2.000000;,
 2.000000;2.000000;2.000000;,
 -2.000000;2.000000;-2.000000;,
 -2.000000;2.000000;2.000000;,
 -2.000000;2.000000;-2.000000;,
 2.000000;2.000000;-2.000000;,
 2.000000;2.000000;2.000000;,
 -2.000000;2.000000;2.000000;,
 -2.000000;-2.000000;-2.000000;,
 -2.000000;-2.000000;2.000000;,
 2.000000;-2.000000;2.000000;,
 2.000000;-2.000000;-2.000000;,
 -2.000000;-2.000000;-2.000000;,
 2.000000;-2.000000;-2.000000;,
 2.000000;-2.000000;-2.000000;,
 2.000000;-2.000000;2.000000;,
 -2.000000;-2.000000;2.000000;,
 2.000000;-2.000000;2.000000;,
 -2.000000;-2.000000;-2.000000;,
 -2.000000;-2.000000;2.000000;;
 12;
 3;16,0,1;,
 3;16,17,0;,
 3;12,13,14;,
 3;12,14,15;,
 3;20,5,21;,
 3;20,4,5;,
 3;22,6,7;,
 3;22,7,23;,
 3;18,19,2;,
 3;18,2,3;,
 3;8,9,10;,
 3;8,10,11;;

 MeshNormals {
  24;
  0.000000;0.000000;1.000000;,
  0.000000;0.000000;1.000000;,
  -1.000000;0.000000;0.000000;,
  -1.000000;0.000000;0.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  1.000000;0.000000;0.000000;,
  1.000000;0.000000;0.000000;,
  0.000000;-1.000000;0.000000;,
  0.000000;-1.000000;0.000000;,
  0.000000;-1.000000;0.000000;,
  0.000000;-1.000000;0.000000;,
  0.000000;1.000000;0.000000;,
  0.000000;1.000000;0.000000;,
  0.000000;1.000000;0.000000;,
  0.000000;1.000000;0.000000;,
  0.000000;0.000000;1.000000;,
  0.000000;0.000000;1.000000;,
  -1.000000;0.000000;0.000000;,
  -1.000000;0.000000;0.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  1.000000;0.000000;0.000000;,
  1.000000;0.000000;0.000000;;
  12;
  3;16,0,1;,
  3;16,17,0;,
  3;12,13,14;,
  3;12,14,15;,
  3;20,5,21;,
  3;20,4,5;,
  3;22,6,7;,
  3;22,7,23;,
  3;18,19,2;,
  3;18,2,3;,
  3;8,9,10;,
  3;8,10,11;;
 }

 MeshTextureCoords {
  24;
  0.000000;0.000000;,
  1.000000;0.000000;,
  0.000000;0.000000;,
  1.000000;0.000000;,
  0.000000;0.000000;,
  1.000000;0.000000;,
  0.000000;0.000000;,
  1.000000;0.000000;,
  0.000000;1.000000;,
  0.000000;0.000000;,
  1.000000;0.000000;,
  1.000000;1.000000;,
  0.000000;0.000000;,
  1.000000;0.000000;,
  1.000000;1.000000;,
  0.000000;1.000000;,
  1.000000;1.000000;,
  0.000000;1.000000;,
  1.000000;1.000000;,
  0.000000;1.000000;,
  0.000000;1.000000;,
  1.000000;1.000000;,
  0.000000;1.000000;,
  1.000000;1.000000;;
 }

 MeshMaterialList {
  6;
  12;
  0,
  0,
  1,
  1,
  2,
  2,
  3,
  3,
  4,
  4,
  5,
  5;

  Material ft {
   1.000000;1.000000;1.000000;1.000000;;
   51.200001;
   0.000000;0.000000;0.000000;;
   0.000000;0.000000;0.000000;;
   TextureFilename {
    "sky_fr.tga";
   }
  }

  Material dn {
   1.000000;1.000000;1.000000;1.000000;;
   51.200001;
   0.000000;0.000000;0.000000;;
   0.000000;0.000000;0.000000;;
   TextureFilename {
    "sky_dn.tga";
   }
  }

  Material bk {
   1.000000;1.000000;1.000000;1.000000;;
   51.200001;
   0.000000;0.000000;0.000000;;
   0.000000;0.000000;0.000000;;
   TextureFilename {
    "sky_bk.tga";
   }
  }

  Material lt {
   1.000000;1.000000;1.000000;1.000000;;
   51.200001;
   0.000000;0.000000;0.000000;;
   0.000000;0.000000;0.000000;;
   TextureFilename {
    "sky_lt.tga";
   }
  }

  Material rt {
   1.000000;1.000000;1.000000;1.000000;;
   51.200001;
   0.000000;0.000000;0.000000;;
   0.000000;0.000000;0.000000;;
   TextureFilename {
    "sky_rt.tga";
   }
  }

  Material up {
   1.000000;1.000000;1.000000;1.000000;;
   51.200001;
   0.000000;0.000000;0.000000;;
   0.000000;0.000000;0.000000;;
   TextureFilename {
    "sky_up.tga";
   }
  }
 }
}
