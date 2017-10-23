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
            StartTime = [datetime]'23 October 2017 01:00:00'
            
        }
        
        User Investrics
        {
            
                Ensure = "Present"  # To ensure the user account does not exist, set Ensure to "Absent"
                UserName = "SomeName"
                Password = $passwordCred # This needs to be a credential object
                DependsOn = "[Group]GroupExample" # Configures GroupExample first
            
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