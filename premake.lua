
--����Workspace���⽫Ӧ����������Ŀ
workspace "LQYEngine"
    architecture "x64"
    startproject "Sandbox"

--����build����
    configurations
    {
        "Debug",
        "Release",
        "Distribution"
    }

--������ļ���ʽ��Ϊ����Debug-Windows-x86_64�����ĸ�ʽ
outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

--������ĿJEngine��ָ�����·����ָ�������Ǿ�̬���ӿ⣬ʹ�����Ե�
project "LQYEngine"
    location "LQYEngine"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

--����build��������ļ���·�����Լ��м�obj�����·��
    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("intermediate/" .. outputdir .. "/%{prj.name}")

--����������ļ�
    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp",
    }

--����������ļ���ַ�������������Public�ļ�
    includedirs
    {
        "%{prj.name}/src/include",
    }

--����ƽָ̨�����ã���windows
    filter "system:windows"
        systemversion "latest"

--Ϊ��ͬ��Build���ö���һЩ�꣬�Ժ�����õ�
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
    
--ͬ����ΪSandbox��Ŀ��ͬ���Ķ��壬��ͬ����  
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

--��Ҫ������include���ǵ�Engine�ļ�
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