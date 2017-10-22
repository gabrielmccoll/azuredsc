configuration TestConfig
{

    Import-DscResource –ModuleName "PSDesiredStateConfiguration" 
    Import-DscResource –ModuleName "xComputerManagement"
    
    Node webservercc
    {
        WindowsFeature IIS
        {
            Ensure               = 'Present'
            Name                 = 'Web-Server'
            IncludeAllSubFeature = $true

        }

        xScheduledTask xScheduledTaskDailyAdd
        {
            TaskName = "Daily"
            ActionExecutable = "C:\windows\system32\WindowsPowerShell\v1.0\powershell.exe"
            ScheduleType = 'Daily'
            DaysInterval = 1
            
        }

    }

    Node NotWebServer
    {
        WindowsFeature IIS
        {
            Ensure               = 'Absent'
            Name                 = 'Web-Server'

        }
    }
    }