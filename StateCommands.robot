*** Settings ***
Documentation    M1M3 State Commands tests.
Force Tags    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${timeout}    30s

*** Test Cases ***
M1M3_Start Command
    [Tags]    functional
    Switch Connection    Commander
    Comment    Issue Start Command.
    ${input}=    issueStartCommand
    Log    ${input}

Start Commander - Verify Timeout without Controller
    [Tags]    functional    skipped
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 1 oUTYYHXdIjyJKwCUOQkaQRdBVJFCktZTvHtiBJRiHCBeEsiiBUGOfcIANZXWsEaxHgOAyGQBrgQYddMxYQEYvirTEALXnUTtnGPAiNUHPoekNlzQpXiQGjlGDjmFIrvMrfkGuRHLQpBJNkIOggNGRZfDwBSaxiZErpJsckuDLrJdykBykZJjUiqnjRlKhsDiEeExkGIdZxuJNqUtAucBlADFDcNOoztzhtwkZcfWhADHAeuNBRMOMpONvHipdXFjhBbOhdHERsDydSNSocscqsjsFvXcAYjXKZsaaxjupnKKQwoacnZoOzsXrwiUJjVzOxhmeOyMvSFuBfFPItRkXfbciaOuEsrbSYerjdnztJiFdDvjVWCUnPpPqkbGKRfUgHXhykqkvOaQgzxSAMjbAwuNCxsyCjVzABzuXXmVAwnZUQcwuyGRIMnpEJcewsCnTynubkOjEIZsPKtgRXeSdYLjrPxWpeGISXOYQmzRncmtOttmioTxSPWQHUESXFhXsxwjmPcKxgQnKFAHGeSRYEiNqMkRvaLElKkDjGicXLdnasTPMTfoiPPojRnqtqRjbKMnznoHTtSZBlHzwODcJEyWhLlsTRWiwFpSVStVAyLRZEZyCHetbiZLgqZIyvIRWsZkImuHcvbzvWPIiFWtcEaIPKsaJDlqzkqcJzJgudqwUtloYIaJpDXpZSexOrPimfPFfoXzpZREYCWsTAhdExWkQNmNToASqxQMMsaxepTbGjzgPaFWmpKEVmVJeiRUiIkiPdeuNrvQfOhOUHGyCpxZLXNfWtbSlziGUHslBFcdneOxKzMfONyOrnJKVqtYOpEgFJMVxQdrQXlwIPkTnSrZCAltkCNYIVPUtkYWBocZyQYAmJNAMthlp
    ${output}=    Read Until Prompt
    Log    ${output}
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( timed out :)

Start Controller
    [Tags]    functional    skipped
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Controller.
    ${input}=    Write    python ${subSystem}_Controller_${component}.py
    ${output}=    Read Until    controller ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready

Start Commander
    [Tags]    functional    skipped
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 1 oUTYYHXdIjyJKwCUOQkaQRdBVJFCktZTvHtiBJRiHCBeEsiiBUGOfcIANZXWsEaxHgOAyGQBrgQYddMxYQEYvirTEALXnUTtnGPAiNUHPoekNlzQpXiQGjlGDjmFIrvMrfkGuRHLQpBJNkIOggNGRZfDwBSaxiZErpJsckuDLrJdykBykZJjUiqnjRlKhsDiEeExkGIdZxuJNqUtAucBlADFDcNOoztzhtwkZcfWhADHAeuNBRMOMpONvHipdXFjhBbOhdHERsDydSNSocscqsjsFvXcAYjXKZsaaxjupnKKQwoacnZoOzsXrwiUJjVzOxhmeOyMvSFuBfFPItRkXfbciaOuEsrbSYerjdnztJiFdDvjVWCUnPpPqkbGKRfUgHXhykqkvOaQgzxSAMjbAwuNCxsyCjVzABzuXXmVAwnZUQcwuyGRIMnpEJcewsCnTynubkOjEIZsPKtgRXeSdYLjrPxWpeGISXOYQmzRncmtOttmioTxSPWQHUESXFhXsxwjmPcKxgQnKFAHGeSRYEiNqMkRvaLElKkDjGicXLdnasTPMTfoiPPojRnqtqRjbKMnznoHTtSZBlHzwODcJEyWhLlsTRWiwFpSVStVAyLRZEZyCHetbiZLgqZIyvIRWsZkImuHcvbzvWPIiFWtcEaIPKsaJDlqzkqcJzJgudqwUtloYIaJpDXpZSexOrPimfPFfoXzpZREYCWsTAhdExWkQNmNToASqxQMMsaxepTbGjzgPaFWmpKEVmVJeiRUiIkiPdeuNrvQfOhOUHGyCpxZLXNfWtbSlziGUHslBFcdneOxKzMfONyOrnJKVqtYOpEgFJMVxQdrQXlwIPkTnSrZCAltkCNYIVPUtkYWBocZyQYAmJNAMthlp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    Start : 1    1
    Should Contain X Times    ${output}    SettingsToApply : oUTYYHXdIjyJKwCUOQkaQRdBVJFCktZTvHtiBJRiHCBeEsiiBUGOfcIANZXWsEaxHgOAyGQBrgQYddMxYQEYvirTEALXnUTtnGPAiNUHPoekNlzQpXiQGjlGDjmFIrvMrfkGuRHLQpBJNkIOggNGRZfDwBSaxiZErpJsckuDLrJdykBykZJjUiqnjRlKhsDiEeExkGIdZxuJNqUtAucBlADFDcNOoztzhtwkZcfWhADHAeuNBRMOMpONvHipdXFjhBbOhdHERsDydSNSocscqsjsFvXcAYjXKZsaaxjupnKKQwoacnZoOzsXrwiUJjVzOxhmeOyMvSFuBfFPItRkXfbciaOuEsrbSYerjdnztJiFdDvjVWCUnPpPqkbGKRfUgHXhykqkvOaQgzxSAMjbAwuNCxsyCjVzABzuXXmVAwnZUQcwuyGRIMnpEJcewsCnTynubkOjEIZsPKtgRXeSdYLjrPxWpeGISXOYQmzRncmtOttmioTxSPWQHUESXFhXsxwjmPcKxgQnKFAHGeSRYEiNqMkRvaLElKkDjGicXLdnasTPMTfoiPPojRnqtqRjbKMnznoHTtSZBlHzwODcJEyWhLlsTRWiwFpSVStVAyLRZEZyCHetbiZLgqZIyvIRWsZkImuHcvbzvWPIiFWtcEaIPKsaJDlqzkqcJzJgudqwUtloYIaJpDXpZSexOrPimfPFfoXzpZREYCWsTAhdExWkQNmNToASqxQMMsaxepTbGjzgPaFWmpKEVmVJeiRUiIkiPdeuNrvQfOhOUHGyCpxZLXNfWtbSlziGUHslBFcdneOxKzMfONyOrnJKVqtYOpEgFJMVxQdrQXlwIPkTnSrZCAltkCNYIVPUtkYWBocZyQYAmJNAMthlp    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional    skipped
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    Start = 1    1
    Should Contain X Times    ${output}    SettingsToApply = oUTYYHXdIjyJKwCUOQkaQRdBVJFCktZTvHtiBJRiHCBeEsiiBUGOfcIANZXWsEaxHgOAyGQBrgQYddMxYQEYvirTEALXnUTtnGPAiNUHPoekNlzQpXiQGjlGDjmFIrvMrfkGuRHLQpBJNkIOggNGRZfDwBSaxiZErpJsckuDLrJdykBykZJjUiqnjRlKhsDiEeExkGIdZxuJNqUtAucBlADFDcNOoztzhtwkZcfWhADHAeuNBRMOMpONvHipdXFjhBbOhdHERsDydSNSocscqsjsFvXcAYjXKZsaaxjupnKKQwoacnZoOzsXrwiUJjVzOxhmeOyMvSFuBfFPItRkXfbciaOuEsrbSYerjdnztJiFdDvjVWCUnPpPqkbGKRfUgHXhykqkvOaQgzxSAMjbAwuNCxsyCjVzABzuXXmVAwnZUQcwuyGRIMnpEJcewsCnTynubkOjEIZsPKtgRXeSdYLjrPxWpeGISXOYQmzRncmtOttmioTxSPWQHUESXFhXsxwjmPcKxgQnKFAHGeSRYEiNqMkRvaLElKkDjGicXLdnasTPMTfoiPPojRnqtqRjbKMnznoHTtSZBlHzwODcJEyWhLlsTRWiwFpSVStVAyLRZEZyCHetbiZLgqZIyvIRWsZkImuHcvbzvWPIiFWtcEaIPKsaJDlqzkqcJzJgudqwUtloYIaJpDXpZSexOrPimfPFfoXzpZREYCWsTAhdExWkQNmNToASqxQMMsaxepTbGjzgPaFWmpKEVmVJeiRUiIkiPdeuNrvQfOhOUHGyCpxZLXNfWtbSlziGUHslBFcdneOxKzMfONyOrnJKVqtYOpEgFJMVxQdrQXlwIPkTnSrZCAltkCNYIVPUtkYWBocZyQYAmJNAMthlp    1
    Should Contain X Times    ${output}    === [ackCommand_Start] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK