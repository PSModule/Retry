# Retry

Retry is a PowerShell module for running a script block with retry, catch, and finally behavior.

## Prerequisites

- PowerShell with `Microsoft.PowerShell.PSResourceGet` available for `Install-PSResource`.
- The [PSModule framework](https://github.com/PSModule) is used for building, testing, and publishing the module.

## Installation

Install the module from the PowerShell Gallery:

```powershell
Install-PSResource -Name Retry
Import-Module -Name Retry
```

## Commands

- `Invoke-Retry` runs a script block until it succeeds or reaches the retry count. The command is also available through the `Retry` alias.

## Usage

Retry an API call up to five times with a five-second delay:

```powershell
Retry -Count 5 -Delay 5 -Run {
	Invoke-RestMethod -Uri 'https://api.myip.com/'
}
```

Run cleanup code after the retry loop:

```powershell
Invoke-Retry -Count 3 -Delay 2 -Run {
	Invoke-RestMethod -Uri 'https://example.invalid/status'
} -Catch {
	Write-Warning 'Request failed'
} -Finally {
	Write-Verbose 'Retry loop finished'
}
```

## Documentation

Command documentation is published at [psmodule.io/Retry](https://psmodule.io/Retry/).

## Contributing

Issues and pull requests are welcome. Please use the repository issue tracker to report bugs, request features, or discuss improvements.
