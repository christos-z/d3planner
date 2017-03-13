precision mediump float;
uniform mat4 u_projMatrix;
uniform vec3 lightDir;
uniform mat4 Bones[24];
uniform float u_alpha;

attribute vec3 vPosition;
attribute vec4 vNormal;
attribute vec2 vTexture;
attribute vec4 vBoneIndex;
attribute vec3 vBoneWeight;

varying vec2 v_Color;
varying vec2 v_Tex;

void main() {
  vec4 position = vec4(vPosition, 1);

  int index = int(vBoneIndex.x);
  vec4 newVertex = (Bones[index] * position) * vBoneWeight.x;
  vec4 newNormal = (Bones[index] * vNormal) * vBoneWeight.x;

  index = int(vBoneIndex.y);
  newVertex = (Bones[index] * position) * vBoneWeight.y + newVertex;
  newNormal = (Bones[index] * vNormal) * vBoneWeight.y + newNormal;

  index = int(vBoneIndex.z);
  newVertex = (Bones[index] * position) * vBoneWeight.z + newVertex;
  newNormal = (Bones[index] * vNormal) * vBoneWeight.z + newNormal;

  newNormal = normalize(newNormal);
  gl_Position = u_projMatrix * newVertex;
  float v_Dot = dot(newNormal.xyz, lightDir);
  float v_SpecDot = -lightDir.x + 2.0 * v_Dot * newNormal.x;
  v_Color = vec2(max(v_Dot, 0.0) * 0.5 + 0.5, v_SpecDot * v_SpecDot);
  v_Tex = vTexture;
}