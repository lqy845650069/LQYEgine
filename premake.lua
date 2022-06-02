
--建立Workspace，这将应用于所有项目
workspace "LQYEngine"
    architecture "x64"
    startproject "Sandbox"

--定义build配置
    configurations
    {
        "Debug",
        "Release",
        "Distribution"
    }

--将输出文件格式定为类似Debug-Windows-x86_64这样的格式
outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

--定义项目JEngine，指定相对路径，指明类型是静态链接库，使用语言等
project "LQYEngine"
    location "LQYEngine"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

--定义build后输出的文件夹路径，以及中间obj的输出路径
    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("intermediate/" .. outputdir .. "/%{prj.name}")

--定义包含的文件
    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp",
    }

--定义包含的文件地址，这里仅包含了Public文件
    includedirs
    {
        "%{prj.name}/src/include",
    }

--定义平台指定配置，如windows
    filter "system:windows"
        systemversion "latest"

--为不同的Build配置定义一些宏，以后可以用到
    filter "configurations:Debug"
        defines "LQY_DEBUG"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        defines "LQY_RELEASE"
        runtime "Release"
        optimize "on"

    filter "configurations:Distribution"
        defines "LQY_DISTRIBUTION"
        runtime "Release"
        optimize "on"
    
--同样，为Sandbox项目做同样的定义，不同的是  
project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("intermediate/" .. outputdir .. "/%{prj.name}")

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

--需要在这里include我们的Engine文件
    includedirs
    {
        "LQYEngine/src",
        "LQYEngine/ThirdParty",
    }

    links
    {
       "LQYEngine"
    }

    filter "system:windows"
        systemversion "latest"

        defines
        {
            "LQY_PLATFORM_WINDOWS"
        }

    filter "configurations:Debug"
        defines "LQY_DEBUG"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        defines "LQY_RELEASE"
        runtime "Release"
        optimize "on"

    filter "configurations:Distribution"
        defines "LQY_DISTRIBUTION"
        runtime "Release"
        optimize "on"