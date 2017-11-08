Class {
	#name : #MetacelloProjectReferenceSpecTestCase,
	#superclass : #MetacelloSpecTestCase,
	#category : #Metacello-TestsCore-Specs
}

{ #category : #tests }
MetacelloProjectReferenceSpecTestCase >> testProjectReferenceMergeSpec [
    | projectReferenceA projectReferenceB projectReference project |
    projectReferenceA := self projectReferenceSpec
        name: 'Project';
        projectReference:
                (self projectSpec
                        name: 'Project';
                        className: 'ConfigurationOfProjectA';
                        versionString: #'stable';
                        yourself);
        yourself.
    projectReferenceB := self projectReferenceSpec
        name: 'Project';
        projectReference:
                (self projectSpec
                        name: 'Project';
                        className: 'ConfigurationOfProjectB';
                        versionString: '1.0';
                        yourself);
        yourself.
    projectReference := projectReferenceA mergeSpec: projectReferenceB.
    self assert: projectReference name = 'Project'.
    self assert: projectReference projectName = 'Project'.
    project := projectReference projectReference.
    self assert: project className = 'ConfigurationOfProjectB'.
    self assert: project versionString = '1.0'
]

{ #category : #tests }
MetacelloProjectReferenceSpecTestCase >> testProjectReferenceSpec [
    | projectReference project |
    projectReference := self projectReferenceSpec
        name: 'Project';
        projectReference:
                (project := self projectSpec
                        name: 'Project';
                        className: 'ConfigurationOfProjectA';
                        versionString: #'stable';
                        yourself);
        yourself.
    self assert: projectReference name = 'Project'.
    self assert: projectReference projectName = 'Project'.
    self assert: projectReference projectReference == project.
    self should: [ projectReference includes: #() ] raise: Error.
    self should: [ projectReference requires: #() ] raise: Error.
    self should: [ projectReference answers: #() ] raise: Error.
    projectReference
        projectDo: [ :prjct | self assert: projectReference == prjct ]
        packageDo: [ :ignored | self assert: false ]
        groupDo: [ :ignored | self assert: false ]
]