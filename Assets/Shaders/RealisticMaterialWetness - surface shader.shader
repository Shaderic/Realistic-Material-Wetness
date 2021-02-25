Shader "Custom/RealisticMaterialWetness"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Roughness ("Roughness (R)", 2D) = "white" {}
        _BumpMap ("Bumpmap", 2D) = "bump" {}
        _AO("AO (R)", 2D) = "white" {}
        
        _Wetness("Wetness", Range(0, 1)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _BumpMap;
        sampler2D _Roughness;
        sampler2D _AO;

        struct Input
        {
            float2 uv_MainTex;
            float4 color : COLOR;
        };

        half _Glossiness;
        half _Metallic;
        half _Wetness;
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            half wetness = IN.color.r * _Wetness;
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            fixed roughness = tex2D (_Roughness, IN.uv_MainTex).r;
            fixed4 ao = tex2D (_AO, IN.uv_MainTex);
            float3 normal =  UnpackNormal (tex2D (_BumpMap, IN.uv_MainTex));
            
            fixed3 albedo = c.rgb;
            albedo = lerp(albedo, albedo*albedo, wetness);
            roughness = lerp(roughness, 0.02, wetness);
            normal = lerp(normal, half3(0, 0, 0.5), wetness);
            
            o.Albedo = IN.color.r;
            o.Occlusion = ao.r;
            o.Smoothness = 1-roughness;
            o.Normal = normal;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
