﻿function Get-TwitterStatuses_MentionsTimeline {
<#
.SYNOPSIS
    Get Tweet timelines

.DESCRIPTION
    GET statuses/mentions_timeline
    
    Returns the 20 most recent mentions (Tweets containing a users's @screen_name) for the authenticating user.
    
    The timeline returned is the equivalent of the one seen when you view your mentions on twitter.com.
    
    This method can only return up to 800 tweets.
    
    See Working with Timelines for instructions on traversing timelines.

.PARAMETER count
    Specifies the number of Tweets to try and retrieve, up to a maximum of 200. The value of count is best thought of as a limit to the number of tweets to return because suspended or deleted content is removed after the count has been applied. We include retweets in the count, even if include_rts is not supplied. It is recommended you always send include_rts=1 when using this API method.

.PARAMETER since_id
    Returns results with an ID greater than (that is, more recent than) the specified ID. There are limits to the number of Tweets which can be accessed through the API. If the limit of Tweets has occured since the since_id, the since_id will be forced to the oldest ID available.

.PARAMETER max_id
    Returns results with an ID less than (that is, older than) or equal to the specified ID.

.PARAMETER trim_user
    When set to either true , t or 1 , each tweet returned in a timeline will include a user object including only the status authors numerical ID. Omit this parameter to receive the complete user object.

.PARAMETER include_entities
    The entities node will not be included when set to false.

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/tweets/timelines/api-reference/get-statuses-mentions_timeline

#>
    [CmdletBinding()]
    Param(
        [string]$count,
        [string]$since_id,
        [string]$max_id,
        [string]$trim_user,
        [string]$include_entities
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'GET'
        [string]$Resource    = '/statuses/mentions_timeline'
        [string]$ResourceUrl = 'https://api.twitter.com/1.1/statuses/mentions_timeline.json'

    }
    Process {

        # Find & Replace any ResourceUrl parameters.
        $UrlParameters = [regex]::Matches($ResourceUrl, '(?<!\w):\w+')
        ForEach ($UrlParameter in $UrlParameters) {
            $UrlParameterValue = $Parameters["$($UrlParameter.Value.TrimStart(":"))"]
            $ResourceUrl = $ResourceUrl -Replace $UrlParameter.Value, $UrlParameterValue
        }

        If (-Not $OAuthSettings) { $OAuthSettings = Get-TwitterOAuthSettings -Resource $Resource }
        Invoke-TwitterAPI -Method $Method -ResourceUrl $ResourceUrl -Parameters $Parameters -OAuthSettings $OAuthSettings

    }
    End {

    }
}